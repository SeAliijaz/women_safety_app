import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('ChatScreen'),
      ),
      body: Center(
        child: Text('ChatScreen'),
      ),
    );
  }
}
