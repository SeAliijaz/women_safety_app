import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Child-Module/register_child_user.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Parent-Module/parent_home_screen.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Parent-Module/register_parent_user.dart';
import 'package:women_safety_app/Screens/Home_Screen/home_screen.dart';
import 'package:women_safety_app/Shared-Preferences/shared_preferences.dart';
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
            goTo(context, ParentHomeScreen());
          } else {
            MySharedPreferences.saveUserType('child');
            goTo(context, HomeScreen());
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        showMessage('No user found for that email.');
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showMessage('Wrong password provided for that user.');
        debugPrint('Wrong password provided for that user.');
      }
    }
    debugPrint(formData['email'].toString());
    debugPrint(formData['password'].toString());
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
                      Text(
                        "CHILD USER LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                            onPressed: () {},
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
