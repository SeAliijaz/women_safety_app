import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Child-Module/child_login_screen.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

import '../../../Utils/constants.dart';
import '../../../Widgets/Custom-Buttons/primary_button.dart';
import '../../../Widgets/Custom-Buttons/secondary_button.dart';

class RegisterChildUser extends StatefulWidget {
  const RegisterChildUser({Key? key}) : super(key: key);

  @override
  State<RegisterChildUser> createState() => _RegisterChildUserState();
}

class _RegisterChildUserState extends State<RegisterChildUser> {
  bool isPasswordShown = true;
  bool isRetypePasswordShown = true;
  final formKey = GlobalKey<FormState>();
  final formData = Map<String, Object>();
  bool isLoading = false;

  ///onsubmit
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "REGISTER AS CHILD",
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
                                    labelText: 'Enter Name',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    prefixIcon: Icon(Icons.person),
                                    onSave: (name) {
                                      formData['name'] = name ?? "";
                                    },
                                    validator: (name) {
                                      if (name!.isEmpty || name.length < 3) {
                                        return 'Enter correct Name';
                                      }
                                      return null;
                                    },
                                  ),

                                  ///Enter phone
                                  CustomTextField(
                                    labelText: 'Enter phone',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    prefixIcon: Icon(Icons.phone),
                                    onSave: (phone) {
                                      formData['phone'] = phone ?? "";
                                    },
                                    validator: (phone) {
                                      if (phone!.isEmpty || phone.length < 10) {
                                        return 'Enter correct phone';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    labelText: 'Enter email',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icon(Icons.email),
                                    onSave: (email) {
                                      formData['cemail'] = email ?? "";
                                    },
                                    validator: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return 'Enter correct email';
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                    labelText: 'Enter guardian email',
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icon(Icons.email),
                                    onSave: (gemail) {
                                      formData['gemail'] = gemail ?? "";
                                    },
                                    validator: (gemail) {
                                      if (gemail!.isEmpty ||
                                          gemail.length < 3 ||
                                          !gemail.contains("@")) {
                                        return 'Enter correct email';
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                    labelText: 'Enter password',
                                    isPassword: isPasswordShown,
                                    prefixIcon: Icon(Icons.vpn_key_rounded),
                                    validator: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'Enter correct password';
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
                                    labelText: 're-Enter password',
                                    isPassword: isRetypePasswordShown,
                                    prefixIcon: Icon(Icons.vpn_key_rounded),
                                    validator: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'Enter correct password';
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
