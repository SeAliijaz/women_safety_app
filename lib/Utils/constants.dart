import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color primaryColor = const Color(0xfffc3b77);

void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}

Widget progressIndicator(BuildContext context) {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: primaryColor,
    color: Colors.red,
    strokeWidth: 7,
  ));
}

String webViewURL0 =
    "https://gulfnews.com/world/asia/pakistan/womens-day-10-pakistani-women-inspiring-the-country-1.77696239";
String webViewURL1 =
    "https://plan-international.org/ending-violence/16-ways-end-violence-girls";
String webViewURL2 =
    "https://www.healthline.com/health/womens-health/self-defense-tips-escape";
String webViewURL3 =
    "https://www.healthline.com/health/womens-health/self-defense-tips-escape";

void showMessage(String msg) {
  Fluttertoast.showToast(msg: msg);
}
