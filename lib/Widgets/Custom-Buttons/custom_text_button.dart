import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CustomTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: AppColors.primaryColor),
      ),
    );
  }
}
