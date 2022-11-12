import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Child-Module/child_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///title of app
      title: 'Women Safety App',

      ///debugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      ///Theme
      theme: ThemeData(
        ///Default Text Theme
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: ChildLogInScreen(),
    );
  }
}
