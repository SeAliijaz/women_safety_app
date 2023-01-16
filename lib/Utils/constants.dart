import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Class of AppColors
class AppColors {
  ///primary
  static const Color primaryColor = Color(0xfffc3b77);

  ///Secondary
  static const Color secondaryColor = Color.fromARGB(255, 255, 134, 174);
}

///Assigning mediaQuery variable to use globally
class MediaQuerySize {
  BuildContext context;

  /// MediaQuerySize(this.context) : assert(context != null);
  MediaQuerySize(this.context);

  /// MediaQuery.of(context).size.height;
  double get height => MediaQuery.of(context).size.height;

  /// MediaQuery.of(context).size.width;
  double get width => MediaQuery.of(context).size.width;
}

///Web view Links Class
class WebViewURLClass {
  ///Web view Links

  static const String webViewURL0 =
      "https://gulfnews.com/world/asia/pakistan/womens-day-10-pakistani-women-inspiring-the-country-1.77696239";
  static const String webViewURL1 =
      "https://plan-international.org/ending-violence/16-ways-end-violence-girls";
  static const String webViewURL2 =
      "https://www.healthline.com/health/womens-health/self-defense-tips-escape";
  static const String webViewURL3 =
      "https://www.healthline.com/health/womens-health/self-defense-tips-escape";
}

///URL CLASS
///For All URl's
class URLClass {
  ///my Profile pic link
  static const String profilePic =
      "https://scontent.flhe13-1.fna.fbcdn.net/v/t39.30808-6/317970217_199027222641391_1579638867389767503_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGlTArU_DeD4hSeoMqbMfoljPTEhVmf3LWM9MSFWZ_ctaGDwC7SmIVovCmJkeNBBAa8m09a3rnj3kwwOmQflcCu&_nc_ohc=_l-Ll-Bf5Y0AX8ehDzK&_nc_ht=scontent.flhe13-1.fna&oh=00_AfDwI1ICockB6ya2y7vqEajVVpSCqk8F11fykalq_yPbmg&oe=63A08498";

  ///Landing Screen Constants
  ///Women ProtectionnImage
  static const String womenProtectionImg =
      "https://img.myloview.com/stickers/women-protection-rgb-color-icon-protect-girls-against-violence-female-empowerment-women-safety-gender-equality-provide-peace-and-security-isolated-vector-illustration-simple-filled-line-drawing-700-267417018.jpg";

  ///Bg Landing Screen
  static const String landingScreenBg =
      "https://images.pexels.com/photos/2088210/pexels-photo-2088210.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";

  ///Guardian Image
  static const String guardianImage =
      "https://st2.depositphotos.com/3557671/11164/v/950/depositphotos_111644880-stock-illustration-man-avatar-icon-of-vector.jpg";

  ///Admin image
  static const String adminImage =
      "https://library.kissclipart.com/20180903/xrw/kissclipart-profile-icon-pink-clipart-computer-icons-user-prof-7c23a79c0e6c539f.png";
}

///Show Messages
class ShowMessage {
  ///FlutterToast
  static flutterToastMsg(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}

class Routes {
  ///Custom Navigator
  static goToPage(BuildContext context, Widget nextScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }
}

class CustomProgessIndicator {
  ///Custom ProgressIndicator
  static Widget indicator(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      backgroundColor: AppColors.primaryColor,
      color: Colors.red,
      strokeWidth: 7,
    ));
  }
}
