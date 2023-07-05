import 'package:chat_app/screens/chat_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/shared_prefernce_service.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/images/icon.png")),
            const Text(
              "AuraChat",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Email...',
                      fillColor: Colors.black,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Password...',
                      fillColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ChatHome()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // This is what you need!
              ),
              label: const Text("Login"),
              icon: const Icon(Icons.login),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text("Or"),
            const Text("SignIn with Social"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatHome()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // This is what you need!
                    ),
                    icon: const Icon(FontAwesomeIcons.google),
                    label: const Text("Google"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatHome()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // This is what you need!
                    ),
                    icon: const Icon(FontAwesomeIcons.facebook),
                    label: const Text("Facebook"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatHome()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // This is what you need!
                    ),
                    icon: const Icon(FontAwesomeIcons.github),
                    label: const Text("Github"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
