import 'package:chat_app/services/firebase_services.dart';
import 'package:chat_app/services/shared_prefernce_service.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/sign_in_provider.dart';
import '../utils/next_screen.dart';
import '../widgets/favourite_contacts.dart';
import '../widgets/recent_chat_list.dart';
import 'login_screen.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  String searchValue = '';

  PreferencesManager preferencesManager = PreferencesManager();

  Future<List<String>> _fetchUserSuggestions(String searchValue) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: searchValue)
        .orderBy('name')
        .limit(10)
        .get();

    final List<String> suggestions = [];

    for (final doc in snapshot.docs) {
      final Map<User, dynamic> userData = doc.data() as Map<User, dynamic>;
      final String displayName = userData['name'] as String;
      suggestions.add(displayName);
    }

    return suggestions;
  }

  void onSearchResult(String selectedUser) {
    // Perform actions when a user is selected
    if (kDebugMode) {
      print('Selected User: $selectedUser');
    }
    // You can navigate to a different screen or perform any other logic here
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.read<SignInProvider>();

    return Scaffold(
      appBar: EasySearchBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('AuraChat'),
        onSearch: (value) => setState(() => searchValue = value),
        asyncSuggestions: (value) async => await _fetchUserSuggestions(value),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.amberAccent,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44.0,
                    backgroundImage: NetworkImage(
                        preferencesManager.getImage(Utils().IMAGE)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        preferencesManager.getName(Utils().NAME),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      IconButton(
                          onPressed: () {
                            sp.userSignOut();
                            nextScreenReplace(context, const LoginScreen());
                          },
                          icon: const Icon(
                            Icons.logout,
                          ) ,
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: FireBaseServices().fetchUserListFromFirebase(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<User> userList = snapshot.data!;
            return Column(
              children: [
                FavouriteContacts(users: userList),
                RecentChatList(users: userList),
              ],
            );
          }
        },
      ),
    );
  }
}
