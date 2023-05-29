import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';
import '../services/firebase_services.dart';

class FavouriteContacts extends StatelessWidget {
  final List<User> users;
  const FavouriteContacts({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Theme.of(context).hintColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
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
                              ChatScreen(user: users[index])),
                    );
                  },
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: NetworkImage(users[index].imageUrl),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  users[index].name.split(" ").first,
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
