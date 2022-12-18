import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Admin-Module/admin_log_in_screen.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/User-Module/user_login_screen.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Guardian-Module/guardian_log_in_screen.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/custom_button.dart';

class LandingScren extends StatefulWidget {
  const LandingScren({Key? key}) : super(key: key);
  @override
  State<LandingScren> createState() => _LandingScrenState();
}

class _LandingScrenState extends State<LandingScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: CachedNetworkImageProvider(URLClass.landingScreenBg),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Title(
                    color: AppColors.primaryColor,
                    child: const Text(
                      "Login With your account",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.5,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
              ),

              ///IMAGE
              Container(
                height: MediaQuerySize(context).height * 0.2,
                width: MediaQuerySize(context).width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color.fromARGB(255, 253, 237, 242),
                      width: 10.0,
                      style: BorderStyle.solid),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: CachedNetworkImageProvider(
                      URLClass.womenProtectionImg,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              ///Custom Buttons
              ///LogIn Screen Button
              SizedBox(
                height: MediaQuerySize(context).height * 0.5,
                width: MediaQuerySize(context).width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      title: "Login As User",
                      isLoginButton: true,
                      onPressed: () {
                        Routes.goTo(context, UserLogInScreen());
                      },
                    ),
                    CustomButton(
                      title: "Login As Gurdian",
                      isLoginButton: true,
                      onPressed: () {
                        Routes.goTo(context, GuardianLogInScreen());
                      },
                    ),
                    CustomButton(
                      title: "Login As Admin",
                      isLoginButton: true,
                      onPressed: () {
                        Routes.goTo(context, AdminLogInScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
