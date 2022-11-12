import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Models/user_model.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Child-Module/child_login_screen.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';
import '../../../Utils/constants.dart';
import '../../../Widgets/Custom-Buttons/primary_button.dart';
import '../../../Widgets/Custom-Buttons/secondary_button.dart';

class RegisterParentUser extends StatefulWidget {
  const RegisterParentUser({Key? key}) : super(key: key);

  @override
  State<RegisterParentUser> createState() => _RegisterParentUserState();
}

class _RegisterParentUserState extends State<RegisterParentUser> {
  bool isPasswordShown = true;
  bool isRetypePasswordShown = true;
  final formKey = GlobalKey<FormState>();
  final formData = Map<String, Object>();
  bool isLoading = false;

  ///onsubmit
  _onFormSubmit() async {
    formKey.currentState!.save();
    if (formData['password'] != formData['rpassword']) {
      showMessage('password and retype password should be equal');
    } else {
      customProgressIndicator(context);
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
              type: 'parent');
          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() {
            goTo(context, ChildLogInScreen());
            setState(() {
              isLoading = false;
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
          showMessage('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
          showMessage('The account already exists for that email.');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        debugPrint(e.toString());
        showMessage(e.toString());
      }
    }
    debugPrint("${formData['email']}");
    debugPrint("${formData['password']}");
  }

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isLoading
                  ? customProgressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "REGISTER AS PARENT",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                                Center(
                                  child: Image.asset(
                                    "assets/logo.png",
                                    scale: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ///Enter name
                                  CustomTextField(
                                    labelText: 'enter name',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    prefixIcon: Icon(Icons.person),
                                    onSave: (name) {
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
                                    labelText: 'enter phone',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    prefixIcon: Icon(Icons.phone),
                                    onSave: (phone) {
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
                                    labelText: 'enter email',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icon(Icons.person),
                                    onSave: (email) {
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
                                    labelText: 'enter child email',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icon(Icons.person),
                                    onSave: (cemail) {
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
                                    labelText: 'enter password',
                                    isPassword: isPasswordShown,
                                    prefixIcon: Icon(Icons.vpn_key_rounded),
                                    validator: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'enter correct password';
                                      }
                                      return null;
                                    },
                                    onSave: (password) {
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
                                    labelText: 'retype password',
                                    isPassword: isRetypePasswordShown,
                                    prefixIcon: Icon(Icons.vpn_key_rounded),
                                    validator: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'enter correct password';
                                      }
                                      return null;
                                    },
                                    onSave: (password) {
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
                                  PrimaryButton(
                                      title: 'REGISTER',
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          return _onFormSubmit();
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                          SecondaryButton(
                              title: 'Login with your account',
                              onPressed: () {
                                goTo(context, ChildLogInScreen());
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
