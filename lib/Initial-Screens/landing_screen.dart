import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/primary_button.dart';

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
            image: CachedNetworkImageProvider(landingScreenBg),
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Title(
                  color: Colors.pink,
                  child: const Text(
                    "Login With your account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color.fromARGB(255, 253, 237, 242),
                    width: 10.0,
                    style: BorderStyle.solid),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: CachedNetworkImageProvider(womenProtectionImg),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              title: "Login As User",
              onPressed: () {},
            ),
            PrimaryButton(
              title: "Login As Gurdian",
              onPressed: () {},
            ),
            PrimaryButton(
              title: "Login As Admin",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
