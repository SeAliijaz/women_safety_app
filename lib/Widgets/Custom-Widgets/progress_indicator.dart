import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

class TitleProgressIndicator extends StatelessWidget {
  final String title;
  const TitleProgressIndicator({
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
        Center(
            child: CircularProgressIndicator(
          backgroundColor: AppColors.primaryColor,
          color: Colors.red,
          strokeWidth: 7,
        )),
      ],
    ));
  }
}
