
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

  @override
  void initState() {
    super.initState();
    currentUser = User(
      id: 'currentUserId',
      name: 'Current User',
      imageUrl: 'https://example.com/images/current_user.jpg', friendId: '',
    );
    filteredUsers = filterUsersWithChats(currentUser);
  }

  List<User> filterUsersWithChats(User currentUser) {
    // Filter users based on whether they have chat with the current user before
    List<User> filteredList = [];

    // for (User user in widget.users) {
    //   if (user.id != currentUser.id) {
    //     bool hasChat = messages.any((message) =>
    //     (message.sender.id == currentUser.id && message.receiver.id == user.id) ||
    //         (message.sender.id == user.id && message.receiver.id == currentUser.id));
    //
    //     if (hasChat) {
    //       filteredList.add(user);
    //     }
    //   }
    // }
    return filteredList;
  }

  String getLastMessageWithUser(User user) {
    // final List<Message> userMessages = messages.where((message) =>
    // (message.sender.id == currentUser.id && message.receiver.id == user.id) ||
    //     (message.sender.id == user.id && message.receiver.id == currentUser.id)).toList();
    //
    // if (userMessages.isNotEmpty) {
    //   final Message lastMessage = userMessages.last;
    //   return lastMessage.text;
    // }

    return 'No messages';
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
          itemCount: widget.users.length,
          itemBuilder: (BuildContext context, int index) {
            final User user = widget.users[index];
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
                              child: Text(
                                getLastMessageWithUser(user),
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('12:34 PM'),
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
