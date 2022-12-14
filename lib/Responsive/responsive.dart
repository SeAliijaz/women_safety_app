import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

///Using this to make responsive for web and app
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.mobileLarge,
  }) : super(key: key);

  static bool isMobile(BuildContext context) => MyUtility(context).width <= 500;

  static bool isMobileLarge(BuildContext context) =>
      MyUtility(context).width <= 700;

  static bool isTablet(BuildContext context) => MyUtility(context).width < 1024;

  static bool isDesktop(BuildContext context) =>
      MyUtility(context).width >= 1024;

  @override
  Widget build(BuildContext context) {
    if (MyUtility(context).width >= 1024) {
      return desktop;
    } else if (MyUtility(context).width >= 700 && tablet != null) {
      return tablet!;
    } else if (MyUtility(context).width >= 500 && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile;
    }
  }
}
//////// OR YOU CAN USE THIS TO MAKE RESPONSIVE ///////////////////s
// class MyUtility(context) {
//   ///isMobile
//   static bool isMobile(BuildContext context) {
//     return MyUtility(context).width < 690;
//   }

//   ///isTablet
//   static bool isTablet(BuildContext context) {
//     return MyUtility(context).width < 850 &&
//         MyUtility(context).width >= 690;
//   }

//   ///isDesktop
//   static bool isDesktop(BuildContext context) {
//     return MyUtility(context).width < 1500 &&
//         MyUtility(context).width >= 850;
//   }

//   ///IsWideDesktop
//   static bool isWideDesktop(BuildContext context) {
//     return MyUtility(context).width >= 1500;
//   }
// }