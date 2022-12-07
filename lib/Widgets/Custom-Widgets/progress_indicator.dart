import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final String title;
  const CustomProgressIndicator({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Center(child: CircularProgressIndicator()),
      ],
    ));
  }
}
