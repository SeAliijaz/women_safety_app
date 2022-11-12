import 'package:flutter/material.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/primary_button.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/secondary_button.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  height: s.height * 0.9,
                  width: s.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "USER LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffc3b77),
                        ),
                      ),
                      Image.asset(
                        "assets/logo.png",
                        scale: 3,
                      ),
                      const CustomTextField(
                        hintText: "Enter Name",
                        prefix: Icon(Icons.person),
                      ),
                      const CustomTextField(
                        hintText: "Enter Password",
                        prefix: Icon(Icons.lock),
                        suffix: Icon(Icons.visibility_off),
                      ),
                      PrimaryButton(
                        title: "login as a user",
                        onPressed: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Forget Password?",
                            style: TextStyle(fontSize: 20),
                          ),
                          SecondaryButton(
                            title: "click here",
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SecondaryButton(
                        title: "Register as a new user",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
