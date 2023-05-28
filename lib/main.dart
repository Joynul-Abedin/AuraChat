import 'package:chat_app/providers/internet_provider.dart';
import 'package:chat_app/providers/sign_in_provider.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/services/shared_prefernce_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final preferencesManager = PreferencesManager();
  await preferencesManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
            hintColor: const Color(0xFFFEF9EB),
          ),
          home: const SplashScreen()),
    );
  }
}
