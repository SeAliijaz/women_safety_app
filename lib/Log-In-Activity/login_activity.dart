import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Initial-Screens/landing_screen.dart';
import 'package:women_safety_app/Module-Widgets/bottom_nav_screen.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/progress_indicator.dart';

class LogInActivityScreen extends StatelessWidget {
  LogInActivityScreen({Key? key}) : super(key: key);
  Future<FirebaseApp> initilize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initilize,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("${streamSnapshot.error}"),
                  ),
                );
              }
              if (streamSnapshot.connectionState == ConnectionState.active) {
                User? user = streamSnapshot.data;
                if (user == null) {
                  return LandingScren();
                }

/*
else if (MyPrefferenc.getEmail() == user.email) {
                  return GuardianHomeScreen();
*/

              } else {
                return BottomNavScreen();
              }
              return Scaffold(
                body: Center(
                  child: CustomProgressIndicator(
                      title: "Checking Authentication..."),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "INITIALIZATION...",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
