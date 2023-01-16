import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:women_safety_app/Models/user_model.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/User-Module/user_login_screen.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

import '../../../Utils/constants.dart';
import '../../../Widgets/Custom-Buttons/custom_button.dart';

class RegisterGuardian extends StatefulWidget {
  const RegisterGuardian({Key? key}) : super(key: key);

  @override
  State<RegisterGuardian> createState() => _RegisterGuardianState();
}

class _RegisterGuardianState extends State<RegisterGuardian> {
  bool isPasswordShown = true;
  bool isRetypePasswordShown = true;
  final formKey = GlobalKey<FormState>();
  final formData = Map<String, Object>();
  bool isLoading = false;

  ///onsubmit
  _onFormSubmit() async {
    formKey.currentState!.save();
    if (formData['password'] != formData['rpassword']) {
      ShowMessage.flutterToastMsg(
          'password and retype password should be equal');
    } else {
      CustomProgessIndicator.indicator(context);
      try {
        setState(() {
          isLoading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: formData['gemail'].toString(),
                password: formData['password'].toString());
        if (userCredential.user != null) {
          final v = userCredential.user!.uid;
          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(v);

          final user = UserModel(
            name: formData['name'].toString(),
            phone: formData['phone'].toString(),
            childEmail: formData['cemail'].toString(),
            guardianEmail: formData['gemail'].toString(),
            id: v,
            type: 'parent',
          );
          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() {
            Routes.goToPage(context, UserLogInScreen());
            setState(() {
              isLoading = false;
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        ShowMessage.flutterToastMsg(e.toString());
        setState(() {
          isLoading = false;
        });
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
          ShowMessage.flutterToastMsg('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
          ShowMessage.flutterToastMsg(
              'The account already exists for that email.');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        debugPrint(e.toString());
        ShowMessage.flutterToastMsg(e.toString());
      }
    }
    debugPrint(formData['email'].toString());
    debugPrint(formData['password'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isLoading
                  ? CustomProgessIndicator.indicator(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Register as Guardian",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 35.5,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor),
                                ),
                                Center(
                                  child: Image.asset(
                                    "assets/logo.png",
                                    height:
                                        MediaQuerySize(context).height / 3.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuerySize(context).height * 0.75,
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ///Enter name
                                  CustomTextField(
                                    labelText: 'Enter Name',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    prefixIcon: Icon(Icons.person),
                                    onSaved: (name) {
                                      formData['name'] = name ?? "";
                                    },
                                    validator: (email) {
                                      if (email!.isEmpty || email.length < 3) {
                                        return 'enter correct name';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    labelText: 'Enter Phone Number',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    prefixIcon: Icon(Icons.phone),
                                    onSaved: (phone) {
                                      formData['phone'] = phone ?? "";
                                    },
                                    validator: (email) {
                                      if (email!.isEmpty || email.length < 10) {
                                        return 'enter correct phone';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    labelText: 'Enter Email',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icon(Icons.email),
                                    onSaved: (email) {
                                      formData['gemail'] = email ?? "";
                                    },
                                    validator: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return 'enter correct email';
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                    labelText: 'Enter Child Email',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icon(Icons.email),
                                    onSaved: (cemail) {
                                      formData['cemail'] = cemail ?? "";
                                    },
                                    validator: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return 'enter correct email';
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                    labelText: 'Enter Password',
                                    isPassword: isPasswordShown,
                                    prefixIcon: Icon(FontAwesomeIcons.key),
                                    validator: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'enter correct password';
                                      }
                                      return null;
                                    },
                                    onSaved: (password) {
                                      formData['password'] = password ?? "";
                                    },
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswordShown = !isPasswordShown;
                                          });
                                        },
                                        icon: isPasswordShown
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                  ),
                                  CustomTextField(
                                    labelText: 'Retype Password',
                                    isPassword: isRetypePasswordShown,
                                    prefixIcon: Icon(FontAwesomeIcons.key),
                                    validator: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'enter correct password';
                                      }
                                      return null;
                                    },
                                    onSaved: (password) {
                                      formData['rpassword'] = password ?? "";
                                    },
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isRetypePasswordShown =
                                                !isRetypePasswordShown;
                                          });
                                        },
                                        icon: isRetypePasswordShown
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                  ),
                                  CustomButton(
                                      title: 'REGISTER',
                                      isLoginButton: true,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          return _onFormSubmit();
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                          CustomButton(
                              title: 'Login with your account',
                              isLoginButton: false,
                              onPressed: () {
                                Routes.goToPage(context, UserLogInScreen());
                              }),
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
