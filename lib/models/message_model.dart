import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final User sender;
  final User receiver;
  final String text;
  final String time;
  late final bool isLiked;
  final bool unread;

  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.time,
    required this.isLiked,
    required this.unread,
  });

  static Future<Message> fromDocument(DocumentSnapshot doc) async {
    final User sender = await User.fromId(doc['sender']);
    final User receiver = await User.fromId(doc['receiver']);

    return Message(
      id: doc['id'],
      sender: sender,
      receiver: receiver,
      text: doc['text'],
      time: doc['time'], // You might need to convert the `Timestamp` to a `String`
      isLiked: doc['isLiked'],
      unread: doc['unread'],
    );
  }
}
