import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/chat_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/contacts_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/profile_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/feedback_screen.dart';
import 'package:women_safety_app/Screens/Home_Screen/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  ///currentIndex
  int currentIndex = 0;

  ///Screens
  List<Widget> screenRoutes = [
    HomeScreen(),
    ContactsScreen(),
    ChatScreen(),
    ProfileScreen(),
    FeedBackScreen(),
  ];

  ///OnTapped
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Body
      body: screenRoutes.elementAt(currentIndex),

      ///BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        ///currentIndex
        currentIndex: currentIndex,

        ///BottomNavigationBarType
        type: BottomNavigationBarType.fixed,

        ///Function OnTapped
        onTap: onTapped,

        ///BottomNavigationBarItem
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'Contacts',
              icon: Icon(
                Icons.contacts,
              )),
          BottomNavigationBarItem(
              label: 'Chats',
              icon: Icon(
                Icons.chat,
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
              )),
          BottomNavigationBarItem(
              label: 'Feedback',
              icon: Icon(
                Icons.feedback,
              ))
        ],
      ),
    );
  }
}
