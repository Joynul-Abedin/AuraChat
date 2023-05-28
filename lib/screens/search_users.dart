// /*
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class UserSearch extends StatefulWidget {
//   const UserSearch({super.key});
//
//   @override
//   UserSearchState createState() => UserSearchState();
// }
//
// class UserSearchState extends State<UserSearch> {
//   TextEditingController _searchController = TextEditingController();
//   late Stream<QuerySnapshot> _usersStream;
//
//   @override
//   void initState() {
//     super.initState();
//     _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
//   }
//
//   void _onSearchTextChanged(String searchText) {
//     setState(() {
//       _usersStream = fetchUsers(searchText).asStream();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: _searchController,
//           onChanged: _onSearchTextChanged,
//           decoration: const InputDecoration(
//             hintText: 'Search users...',
//           ),
//         ),
//         Expanded(
//           child: StreamBuilder<QuerySnapshot>(
//             stream: _usersStream,
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const CircularProgressIndicator();
//               }
//
//               final users = snapshot.data?.docs;
//
//               return ListView.builder(
//                 itemCount: users?.length,
//                 itemBuilder: (context, index) {
//                   final user = users[index].data();
//                   return ListTile(
//                     title: Text(user['name']),
//                     subtitle: Text(user['email']),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
// */
