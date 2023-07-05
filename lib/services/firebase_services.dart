import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/user_model.dart';

class FireBaseServices {
  Future<List<DocumentSnapshot>> fetchUsers(String searchTerm) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .orderBy('name')
        .get();
    return snapshot.docs;
  }

  Future<List<User>> fetchUserListFromFirebase() async {
    List<User> userList = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;
        User user = User(
          id: documentSnapshot.id,
          name: userData['name'] as String,
          imageUrl: userData['image_url'] as String,
          friendId: '',
          fcmToken: userData['fcmToken'],
        );
        userList.add(user);
      }
    } catch (error) {
      // Handle any errors that occur during fetching
      print('Error fetching user list: $error');
    }
    return userList;
  }
}
