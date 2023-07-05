import 'package:chat_app/services/shared_prefernce_service.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../screens/chat_screen.dart';

class RecentChatList extends StatefulWidget {
  final List<User> users;

  const RecentChatList({super.key, required this.users});

  @override
  RecentChatListState createState() => RecentChatListState();
}

class RecentChatListState extends State<RecentChatList> {
  late User currentUser;
  late List<User> filteredUsers;
  final PreferencesManager preferencesManager = PreferencesManager();

  @override
  void initState() {
    super.initState();
    currentUser = User(
      id: preferencesManager.getID(Utils().ID),
      name: preferencesManager.getName(Utils().NAME),
      imageUrl: preferencesManager.getImage(Utils().IMAGE),
      friendId: '',
      fcmToken: '',
    );
    filteredUsers = filterOutCurrentUser(currentUser, widget.users);
  }

  List<User> filterUsersWithChats(User currentUser, List<User> allUsers) {
    List<User> filteredList = [];

    for (User user in allUsers) {
      if (user.id != currentUser.id) {
          filteredList.add(user);
      }
    }
    return filteredList;
  }

  List<User> filterOutCurrentUser(User currentUser, List<User> allUsers) {
    return allUsers.where((user) => user.id != currentUser.id).toList();
  }



  Future<Message> getLastMessageWithUser(User user) async {
    // Query for messages from currentUser to user
    final QuerySnapshot sentMessages = await FirebaseFirestore.instance
        .collection('messages')
        .where('sender', isEqualTo: currentUser.id)
        .where('receiver', isEqualTo: user.id)
        .orderBy('time', descending: true)
        .limit(1)
        .get();

    // Query for messages from user to currentUser
    final QuerySnapshot receivedMessages = await FirebaseFirestore.instance
        .collection('messages')
        .where('sender', isEqualTo: user.id)
        .where('receiver', isEqualTo: currentUser.id)
        .orderBy('time', descending: true)
        .limit(1)
        .get();

    // If no messages exist in either direction, return a placeholder message
    if (sentMessages.docs.isEmpty && receivedMessages.docs.isEmpty) {
      return Message(
        id: "0",
        sender: currentUser,
        receiver: user,
        text: 'No messages',
        time: DateTime.now().toString(),
        isLiked: false,
        unread: false,
      );
    }

    // If no messages were sent by currentUser, return the latest received message
    if (sentMessages.docs.isEmpty) {
      return await Message.fromDocument(receivedMessages.docs.first);
    }

    // If no messages were received from user, return the latest sent message
    if (receivedMessages.docs.isEmpty) {
      return await Message.fromDocument(sentMessages.docs.first);
    }

    // If messages exist in both directions, compare their timestamps and return the latest one
    final Message latestSentMessage =
        await Message.fromDocument(sentMessages.docs.first);
    final Message latestReceivedMessage =
        await Message.fromDocument(receivedMessages.docs.first);

    return latestSentMessage.time.compareTo(latestReceivedMessage.time) >= 0
        ? latestSentMessage
        : latestReceivedMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (BuildContext context, int index) {
            final User user = filteredUsers[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(user: user),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(user.imageUrl),
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .5,
                              child: FutureBuilder<Message>(
                                future: getLastMessageWithUser(user),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Message> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // The future is still running and hasn't completed yet
                                    return const LinearProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // An error occurred while running the future
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // The future has completed with a result
                                    return Text(
                                      snapshot.data!.text,
                                      style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('12:34 PM'),
                        Container(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
