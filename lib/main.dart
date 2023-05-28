import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/services/shared_prefernce_service.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencesManager = PreferencesManager();
  await preferencesManager.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final isLoggedIn = PreferencesManager.instance.getBool(Utils().IS_LOGGED_IN);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.amber,
          hintColor: Colors.amberAccent,
          textTheme: GoogleFonts.aladinTextTheme(Theme.of(context).textTheme)),
      home: LoginPage(),
    );
  }
}
