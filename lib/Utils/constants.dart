import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Primary Color
Color primaryColor = const Color(0xfffc3b77);

///Assigning mediaQuery variable to use globally
class MediaQuerySize {
  BuildContext context;
  // MediaQuerySize(this.context) : assert(context != null);
  MediaQuerySize(this.context);

  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;
}

///Web view Links
class WebViewURLClass {
  String webViewURL0 =
      "https://gulfnews.com/world/asia/pakistan/womens-day-10-pakistani-women-inspiring-the-country-1.77696239";
  String webViewURL1 =
      "https://plan-international.org/ending-violence/16-ways-end-violence-girls";
  String webViewURL2 =
      "https://www.healthline.com/health/womens-health/self-defense-tips-escape";
  String webViewURL3 =
      "https://www.healthline.com/health/womens-health/self-defense-tips-escape";
}

class URLClass {
  ///my Profile pic link
  String profilePic =
      "https://scontent.flhe13-1.fna.fbcdn.net/v/t39.30808-6/306335296_178170768060370_8576649906092955232_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGFWgXu_YrNlSNYB5Q7pkKbmqpAXXkGCBiaqkBdeQYIGFhAMtHSYistLSqHcQFpFDJqSf-tthgbd4CIprxKnxta&_nc_ohc=DcTirbqZKuYAX8J6Thw&_nc_ht=scontent.flhe13-1.fna&oh=00_AfAGF5psdEF7Seph2XYxZCEhGwBZThVCXfEzKyYcDI6Vag&oe=63963306";

  ///Landing Screen Constants
  ///Women ProtectionnImage
  String womenProtectionImg =
      "https://img.myloview.com/stickers/women-protection-rgb-color-icon-protect-girls-against-violence-female-empowerment-women-safety-gender-equality-provide-peace-and-security-isolated-vector-illustration-simple-filled-line-drawing-700-267417018.jpg";

  ///Bg Landing Screen
  String landingScreenBg =
      "https://images.pexels.com/photos/2088210/pexels-photo-2088210.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
}

class ShowMessages {
  ///FlutterToast
  void message(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}

///Custom Navigator
void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

///Custom DialougeBox
customDialogBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

///Custom ProgressIndicator
Widget customProgressIndicator(BuildContext context) {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: primaryColor,
    color: Colors.red,
    strokeWidth: 7,
  ));
}
