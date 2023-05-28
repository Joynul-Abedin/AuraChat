import 'package:chat_app/widgets/favourite_contacts.dart';
import 'package:chat_app/widgets/recent_chat_list.dart';
import 'package:flutter/material.dart';

class ChatHome extends StatelessWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 35.0,
            )),
        title: const Text(
          "Chat",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 35.0,
              )),
        ],
        elevation: 0.0,
      ),
      body: Column(
        children: const [FavouriteContacts(), RecentChatList()],
      ),
    );
  }
}
