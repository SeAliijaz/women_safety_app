import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/User-Module/register_user.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Guardian-Module/guardian_home_screen.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Guardian-Module/register_guardian.dart';
import 'package:women_safety_app/Screens/Home_Screen/home_screen.dart';
import 'package:women_safety_app/Shared-Preferences/shared_preferences.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/custom_button.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/custom_text_button.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

class UserLogInScreen extends StatefulWidget {
  const UserLogInScreen({Key? key}) : super(key: key);

  @override
  State<UserLogInScreen> createState() => _UserLogInScreenState();
}

class _UserLogInScreenState extends State<UserLogInScreen> {
  bool isPasswordShown = false;
  final formKey = GlobalKey<FormState>();
  final formData = Map<String, Object>();
  bool isLoading = false;
  _onFormSubmit() async {
    formKey.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: formData['email'].toString(),
              password: formData['password'].toString());
      if (userCredential.user != null) {
        setState(() {
          isLoading = false;
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if (value['type'] == 'parent') {
            debugPrint(value['type']);
            MySharedPreferences.saveUserType('parent');
            RoutesAndIndicators().goTo(context, GuardianHomeScreen());
          } else {
            MySharedPreferences.saveUserType('child');
            RoutesAndIndicators().goTo(context, HomeScreen());
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        ShowMessages().message('No user found for that email.');
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ShowMessages().message('Wrong password provided for that user.');
        debugPrint('Wrong password provided for that user.');
      }
    }
    debugPrint(formData['email'].toString());
    debugPrint(formData['password'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuerySize(context).height,
          width: MediaQuerySize(context).width,
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuerySize(context).height * 0.9,
                width: MediaQuerySize(context).width,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "USER LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/logo.png",
                          height: MediaQuerySize(context).height / 3.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          labelText: "Enter email",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icon(Icons.email),
                          onSaved: (email) {
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          labelText: "Enter Password",
                          isPassword: isPasswordShown,
                          onSaved: (password) {
                            formData["password"] = password ?? "";
                          },
                          validator: (password) {
                            if (password!.isEmpty || password.length < 7) {
                              return "Incorrect Password";
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icon(FontAwesomeIcons.key),
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
                      ),
                      CustomButton(
                        title: "login as a user",
                        isLoginButton: true,
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
                          CustomTextButton(
                            title: "Click here",
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextButton(
                              title: "Register as User",
                              onPressed: () {
                                RoutesAndIndicators()
                                    .goTo(context, RegisterUser());
                              },
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: CustomTextButton(
                              title: "Register as Guardian",
                              onPressed: () {
                                RoutesAndIndicators()
                                    .goTo(context, RegisterGuardian());
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
