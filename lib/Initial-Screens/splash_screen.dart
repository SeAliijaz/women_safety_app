import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Initial-Screens/landing_screen.dart';
import 'package:women_safety_app/Utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () {
      Routes.goTo(context, const LandingScren());
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.primaries[15],
      body: SizedBox(
        height: MediaQuerySize(context).height,
        width: MediaQuerySize(context).width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  height: MediaQuerySize(context).height * 0.45,
                  width: MediaQuerySize(context).width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: CachedNetworkImageProvider(
                          URLClass().womenProtectionImg),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Women Safety App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuerySize(context).height * 0.045,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
