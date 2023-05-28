import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class FavouriteContacts extends StatelessWidget {
  const FavouriteContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Theme.of(context).hintColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favorites.length,
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
                              ChatScreen(user: favorites[index])),
                    );
                  },
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: AssetImage(favorites[index].imageUrl),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  favorites[index].name,
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
