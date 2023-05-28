import 'package:chat_app/models/user_model.dart';

class Message {
  final User sender;
  final User receiver;
  final String text;
  final String time;
  final bool isLiked;
  final bool unread;

  Message({
    required this.sender,
    required this.receiver,
    required this.text,
    required this.time,
    required this.isLiked,
    required this.unread,
  });
}

// YOU - current user
final User currentUser = User(
  id: "0",
  name: 'Current User',
  imageUrl: 'assets/images/greg.jpg',
);

// USERS
final User dolan = User(
  id: "1",
  name: 'Dolan',
  imageUrl: 'assets/images/sophia.jpg',
);
final User shokal = User(
  id: "2",
  name: 'Shokal',
  imageUrl: 'assets/images/james.jpg',
);
final User raian = User(
  id: "3",
  name: 'Raian',
  imageUrl: 'assets/images/john.jpg',
);
final User aqib = User(
  id: "4",
  name: 'Aqib',
  imageUrl: 'assets/images/olivia.jpg',
);
final User sizan = User(
  id: "5",
  name: 'Sizan',
  imageUrl: 'assets/images/sam.jpg',
);
final User utchas = User(
  id: "6",
  name: 'Utchas',
  imageUrl: 'assets/images/sophia.jpg',
);
final User saiful = User(
  id: "7",
  name: 'Saiful',
  imageUrl: 'assets/images/steven.jpg',
);
final User greg = User(
  id: "8",
  name: 'Greg',
  imageUrl: 'assets/images/greg.jpg',
);
final User james = User(
  id: "9",
  name: 'James',
  imageUrl: 'assets/images/james.jpg',
);
final User john = User(
  id: "10",
  name: 'John',
  imageUrl: 'assets/images/john.jpg',
);
final User olivia = User(
  id: "11",
  name: 'Olivia',
  imageUrl: 'assets/images/olivia.jpg',
);
final User sam = User(
  id: "12",
  name: 'Sam',
  imageUrl: 'assets/images/sam.jpg',
);
final User sophia = User(
  id: "13",
  name: 'Sophia',
  imageUrl: 'assets/images/sophia.jpg',
);
final User steven = User(
  id: "14",
  name: 'Steven',
  imageUrl: 'assets/images/steven.jpg',
);

// FAVORITE CONTACTS
List<User> favorites = [
  dolan,
  shokal,
  raian,
  aqib,
  sizan,
  utchas,
  saiful,
  sam,
  steven,
  olivia,
  john,
  greg,
];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: dolan,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: shokal,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: raian,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
    receiver: shokal,
  ),
  Message(
    sender: aqib,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
    receiver: shokal,

  ),
  Message(
    sender: sizan,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
    receiver: shokal,
  ),
  Message(
    sender: utchas,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
    receiver: shokal,
  ),
  Message(
    sender: saiful,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
    receiver: shokal,
  ),
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
    receiver: shokal,
  ),
  Message(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
    receiver: shokal,
  ),
  Message(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
    receiver: shokal,
  ),
  Message(
    sender: greg,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
    receiver: shokal,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: james,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
  Message(
    sender: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
    receiver: shokal,
  ),
];
