import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContactsScreen'),
      ),
      body: Center(
        child: Text('ContactsScreen'),
      ),
    );
  }
}
