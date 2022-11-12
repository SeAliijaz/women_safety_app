import 'package:flutter/material.dart';

class ForgetPassowrdScreen extends StatelessWidget {
  const ForgetPassowrdScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'This Feature will be added soon',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
