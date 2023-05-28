import 'package:chat_app/providers/internet_provider.dart';
import 'package:chat_app/providers/sign_in_provider.dart';
import 'package:chat_app/screens/chat_home.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/services/shared_prefernce_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final preferencesManager = PreferencesManager();
  await preferencesManager.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sp = context.read<SignInProvider>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Chat UI',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.amber,
            hintColor: Color(0xFFFEF9EB),
          ),
          home:
              sp.isSignedIn == false ? const LoginScreen() : const ChatHome()),
    );
  }
}
