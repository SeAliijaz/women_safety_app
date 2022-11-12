import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Child-Module/register_child_user.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Forget-Pass_Module/forget_password_screen.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Parent-Module/register_parent_user.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/primary_button.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/secondary_button.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

class ChildLogInScreen extends StatefulWidget {
  const ChildLogInScreen({Key? key}) : super(key: key);

  @override
  State<ChildLogInScreen> createState() => _ChildLogInScreenState();
}

class _ChildLogInScreenState extends State<ChildLogInScreen> {
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
                      Center(
                        child: Image.asset(
                          "assets/logo.png",
                          scale: 3,
                        ),
                      ),
                      CustomTextField(
                        labelText: "Enter email",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.email),
                        onSave: (email) {
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
                        labelText: "Enter Password",
                        isPassword: isPasswordShown,
                        onSave: (password) {
                          formData["password"] = password ?? "";
                        },
                        validator: (password) {
                          if (password!.isEmpty || password.length < 7) {
                            return "Incorrect Password";
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Icon(Icons.vpn_key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordShown = !isPasswordShown;
                            });
                          },
                          icon: isPasswordShown == true
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
                            onPressed: () {
                              goTo(context, ForgetPassowrdScreen());
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              title: "Register as child",
                              onPressed: () {
                                goTo(context, RegisterChildUser());
                              },
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: SecondaryButton(
                              title: "Register as Parent",
                              onPressed: () {
                                goTo(context, RegisterParentUser());
                              },
                            ),
                          ),
                        ],
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
