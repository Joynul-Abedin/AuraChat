import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';
import '../services/firebase_services.dart';
import '../services/shared_prefernce_service.dart';
import '../utils/utils.dart';

class FavouriteContacts extends StatefulWidget {
  final List<User> users;
  const FavouriteContacts({Key? key, required this.users}) : super(key: key);

  @override
  State<FavouriteContacts> createState() => _FavouriteContactsState();
}

class _FavouriteContactsState extends State<FavouriteContacts> {
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

  List<User> filterOutCurrentUser(User currentUser, List<User> allUsers) {
    return allUsers.where((user) => user.id != currentUser.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Theme.of(context).hintColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(user: filteredUsers[index])),
                    );
                  },
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: NetworkImage(filteredUsers[index].imageUrl),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  filteredUsers[index].name.split(" ").first,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
