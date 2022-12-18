import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/Module-Widgets/bottom_nav_screen.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Guardian-Module/guardian_home_screen.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/User-Module/user_login_screen.dart';
import 'package:women_safety_app/Shared-Preferences/shared_preferences.dart';
import 'package:women_safety_app/Utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPreferences.init();
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
        ///setting color

        ///Default Text Theme
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      // home: LogInActivityChecking(),
      home: FutureBuilder(
        future: MySharedPreferences.getUserType(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == "") {
            return const UserLogInScreen();
          }
          if (snapshot.data == "child") {
            return const BottomNavScreen();
          }
          if (snapshot.data == "parent") {
            return const GuardianHomeScreen();
          }
          return CustomProgessIndicator.indicator(context);
        },
      ),
    );
  }
}
