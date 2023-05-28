import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseServices {
  Future<List<DocumentSnapshot>> fetchUsers(String searchTerm) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .orderBy('name')
        .get();
    return snapshot.docs;
  }
}
