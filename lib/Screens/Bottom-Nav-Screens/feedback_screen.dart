import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('FeedBack'),
      ),
      body: Center(
        child: Text('FeedBackScreen'),
      ),
    );
  }
}
