import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/favourite_contacts.dart';
import '../widgets/recent_chat_list.dart';

class ChatHome extends StatefulWidget {
  ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  String searchValue = '';

  Future<List<String>> _fetchUserSuggestions(String searchValue) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: searchValue)
        .orderBy('name')
        .limit(10)
        .get();

    final List<String> suggestions = [];

    for (final doc in snapshot.docs) {
      final Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      final String displayName = userData['name'] as String;
      suggestions.add(displayName);
    }

    return suggestions;
  }

  void onSearchResult(String selectedUser) {
    // Perform actions when a user is selected
    print('Selected User: $selectedUser');
    // You can navigate to a different screen or perform any other logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Example'),
        actions: [IconButton(icon: const Icon(Icons.person), onPressed: () {})],
        onSearch: (value) => setState(() => searchValue = value),
        asyncSuggestions: (value) async => await _fetchUserSuggestions(value),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          FavouriteContacts(),
          RecentChatList(),
        ],
      ),
    );
  }
}
