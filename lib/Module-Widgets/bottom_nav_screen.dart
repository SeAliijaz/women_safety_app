import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/add_contacts_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/chat_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/profile_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/rating_app_screen.dart';
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
    AddTrustedContacts(),
    ChatScreen(),
    ProfileScreen(),
    RatingAppScreen(),
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
        items: const [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(
              label: 'Contacts', icon: Icon(Icons.contacts_outlined)),
          BottomNavigationBarItem(
              label: 'Chats', icon: Icon(Icons.message_outlined)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(Icons.person_outline)),
          BottomNavigationBarItem(
              label: 'Review', icon: Icon(Icons.star_outline))
        ],
      ),
    );
  }
}
