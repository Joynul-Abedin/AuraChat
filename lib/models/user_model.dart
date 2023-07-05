import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String imageUrl;
  final String friendId;
  final String fcmToken;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.friendId,
    required this.fcmToken,
  });

  static Future<User> fromId(String id) async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(id).get();

    return User(
      id: doc.id,
      name: doc['name'],
      imageUrl: doc['image_url'],
      friendId: "",
      fcmToken: doc['fcmToken'],
    );
  }
}
