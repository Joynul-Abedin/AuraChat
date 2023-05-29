import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../providers/sign_in_provider.dart';
import '../services/socket_io_services.dart';


class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late User currentUser;
  late List<Message> messages;
  final CallService _callService = CallService();


  @override
  void initState() {
    CallService();
    final sp = context.read<SignInProvider>();
    super.initState();

    currentUser = User(
      id: sp.uid ?? "",
      name: sp.name ?? "AuraChat",
      imageUrl: sp.imageUrl ?? "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png", friendId: '',
    );
    messages = [];
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('messages')
        .where('participants', arrayContains: [currentUser.id , widget.user.id])
        .orderBy('time')
        .get();

    final List<Message> fetchedMessages = [];

    for (final doc in snapshot.docs) {
      final Map<String, dynamic> messageData = doc.data() as Map<String, dynamic>;
      final String text = messageData['text'] as String;
      final String time = messageData['time'] as String;
      final bool isLiked = messageData['isLiked'] as bool;
      final String senderId = messageData['senderId'] as String;
      final String receiverId = messageData['receiverId'] as String;

      final User sender = User(
        id: senderId,
        name: 'Sender', // Replace with appropriate field from Firestore
        imageUrl: 'sender_image_url', friendId: '', // Replace with appropriate field from Firestore
      );

      final User receiver = User(
        id: receiverId,
        name: 'Receiver', // Replace with appropriate field from Firestore
        imageUrl: 'receiver_image_url', friendId: '', // Replace with appropriate field from Firestore
      );

      final Message message = Message(
        sender: sender,
        receiver: receiver,
        text: text,
        time: time,
        isLiked: isLiked,
        unread: true,
      );

      fetchedMessages.add(message);
    }

    setState(() {
      messages = fetchedMessages;
    });
  }

  void sendMessage() async {
    final String text = _messageController.text.trim();
    if (text.isEmpty) return;

    final Message newMessage = Message(
      sender: currentUser,
      receiver: widget.user,
      text: text,
      time: DateTime.now().toString(),
      isLiked: false,
      unread: true,
    );

    // Store the message in Cloud Firestore
    await FirebaseFirestore.instance.collection('messages').add({
      'text': newMessage.text,
      'time': newMessage.time,
      'isLiked': newMessage.isLiked,
      'senderId': newMessage.sender.id,
      'receiverId': newMessage.receiver.id,
      'participants': [newMessage.sender.id, newMessage.receiver.id],
    });

    setState(() {
      messages.insert(0, newMessage);
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.user.name,
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.call),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              _callService.startCall(widget.user.id);
            },
          ),
          IconButton(
            icon: const Icon(Icons.video_call),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              _callService.startCall(widget.user.id);
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(top: 15.0),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = messages[index];
                    final bool isMe = message.sender.id == currentUser.id;
                    return _buildMessage(message, isMe);
                  },
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo),
            iconSize: 25.0,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
                fillColor: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).hintColor : const Color(0xFFFFEFEE),
        borderRadius: isMe
            ? const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
            : const BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(children: [
            Text(
              message.time,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ]),
          const SizedBox(height: 8.0),
          Text(
            message.text,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: message.isLiked
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isLiked
              ? Theme.of(context).primaryColor
              : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }
}

