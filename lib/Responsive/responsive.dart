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

  static bool isMobile(BuildContext context) =>
      MediaQuerySize(context).width <= 500;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuerySize(context).width <= 700;

  static bool isTablet(BuildContext context) =>
      MediaQuerySize(context).width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuerySize(context).width >= 1024;

  @override
  Widget build(BuildContext context) {
    if (MediaQuerySize(context).width >= 1024) {
      return desktop;
    } else if (MediaQuerySize(context).width >= 700 && tablet != null) {
      return tablet!;
    } else if (MediaQuerySize(context).width >= 500 && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile;
    }
  }
}
//////// OR YOU CAN USE THIS TO MAKE RESPONSIVE ///////////////////s
// class MediaQuerySize(context) {
//   ///isMobile
//   static bool isMobile(BuildContext context) {
//     return MediaQuerySize(context).width < 690;
//   }

//   ///isTablet
//   static bool isTablet(BuildContext context) {
//     return MediaQuerySize(context).width < 850 &&
//         MediaQuerySize(context).width >= 690;
//   }

//   ///isDesktop
//   static bool isDesktop(BuildContext context) {
//     return MediaQuerySize(context).width < 1500 &&
//         MediaQuerySize(context).width >= 850;
//   }

//   ///IsWideDesktop
//   static bool isWideDesktop(BuildContext context) {
//     return MediaQuerySize(context).width >= 1500;
//   }
// }