import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/chat_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/child_home_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/contacts_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/profile_screen.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/rating_app_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      ChildHomeScreen(),
      ContactsScreen(),
      ChatScreen(),
      RatingAppScreen(),
      ProfileScreen(),
    ];

    int _currentIndex = 0;

    void _onTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home,
                )),
            BottomNavigationBarItem(
                label: "Contacts",
                icon: Icon(
                  Icons.home,
                )),
            BottomNavigationBarItem(
                label: "Chat",
                icon: Icon(
                  Icons.home,
                )),
            BottomNavigationBarItem(
                label: "Rating App",
                icon: Icon(
                  Icons.home,
                )),
            BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(
                  Icons.home,
                )),
          ]),
      body: Center(
        child: _screens.elementAt(_currentIndex),
      ),
    );
  }
}
