import 'package:flutter/material.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/primary_button.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/secondary_button.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isPasswordShown = false;
  final formKey = GlobalKey<FormState>();
  final formData = Map<String, Object>();

  _onFormSubmit() {
    formKey.currentState!.save();
    debugPrint("${formData["email"]}");
    debugPrint("${formData["password"]}");
  }

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: s.height * 0.9,
                width: s.width,
                child: Form(
                  key: formKey,
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
                      CustomTextField(
                        hintText: "Enter email",
                        textInputAction: TextInputAction.next,
                        keyboardtype: TextInputType.emailAddress,
                        prefix: Icon(Icons.email),
                        onsave: (email) {
                          formData["email"] = email ?? "";
                        },
                        validator: (email) {
                          if (email!.isEmpty ||
                              email.length < 3 ||
                              !email.contains("@")) {
                            return "Incorrect Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        hintText: "Enter Password",
                        isPassword: isPasswordShown,
                        onsave: (password) {
                          formData["password"] = password ?? "";
                        },
                        validator: (password) {
                          if (password!.isEmpty || password.length < 7) {
                            return "Incorrect Pa ssword";
                          } else {
                            return null;
                          }
                        },
                        prefix: Icon(Icons.vpn_key),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordShown = !isPasswordShown;
                            });
                          },
                          icon: isPasswordShown
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      PrimaryButton(
                        title: "login as a user",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            return _onFormSubmit();
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Forget Password?",
                            style: TextStyle(fontSize: 20),
                          ),
                          SecondaryButton(
                            title: "Click here",
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
