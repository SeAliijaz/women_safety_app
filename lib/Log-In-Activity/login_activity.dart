import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Initial-Screens/landing_screen.dart';
import 'package:women_safety_app/Module-Widgets/bottom_nav_screen.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/progress_indicator.dart';

class LogInActivityChecking extends StatelessWidget {
  LogInActivityChecking({Key? key}) : super(key: key);
  final Future<FirebaseApp> initializeApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    ///Future Builder
    return FutureBuilder(
      future: initializeApp,
      builder: (BuildContext context, AsyncSnapshot futureSnapshot) {
        if (futureSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${futureSnapshot.error}"),
            ),
          );
        }
        if (futureSnapshot.connectionState == ConnectionState.done) {
          ///Stream Builder
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
                  return const LandingScren();
                }
/*else if (MyPrefferenc.getEmail() == user.email) {return GuardianHomeScreen();*/
              } else {
                return const BottomNavScreen();
              }
              return Scaffold(
                body: Center(
                  child: TitleProgressIndicator(
                    title: "Checking Authentication...".toUpperCase(),
                  ),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: TitleProgressIndicator(
              title: "Initilization...".toUpperCase(),
            ),
          ),
        );
      },
    );
  }
}
