import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

class CustomButton extends StatelessWidget {
  String? title;
  bool? isLoginButton;
  VoidCallback? onPressed;
  bool? isLoading;

  CustomButton(
      {Key? key,
      this.title,
      this.isLoading = false,
      this.isLoginButton = false,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isLoginButton == false ? Colors.white : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isLoginButton == false ? Colors.black : Colors.red,
          ),
        ),
        child: Center(
          child: Text(
            title ?? "button",
            style: TextStyle(
              color: isLoginButton == false ? Colors.black : Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
