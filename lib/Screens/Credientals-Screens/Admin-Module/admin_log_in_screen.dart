import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Admin-Module/admin_home_screen.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/custom_button.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

class AdminLogInScreen extends StatefulWidget {
  static const String id = "adminlogin";

  const AdminLogInScreen({Key? key}) : super(key: key);
  @override
  State<AdminLogInScreen> createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;
  final String username = "admin";
  final String Password = "12345";

  bool isPassword = false;

  submit(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      if (emailC.text == username && passwordC.text == Password) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AdminHomeScreen()));
      }

      setState(() {
        formStateLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuerySize(context).height,
          width: MediaQuerySize(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Admin Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: MediaQuerySize(context).height * 0.60,
                width: MediaQuerySize(context).width,
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuerySize(context).height * 0.2,
                        width: MediaQuerySize(context).width,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(255, 248, 201, 217),
                            width: 10.0,
                            style: BorderStyle.solid,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: CachedNetworkImageProvider(
                                URLClass().adminImage),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          controller: emailC,
                          labelText: "Email...",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.secondaryColor,
                          ),
                          validator: (v) {
                            if (!v!.contains("@gmail.com") && v.length < 0) {
                              return "email is badly formated";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          controller: passwordC,
                          labelText: "Password...",
                          prefixIcon: Icon(
                            Icons.key_outlined,
                            color: AppColors.secondaryColor,
                          ),
                          isPassword: isPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            icon: isPassword
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppColors.secondaryColor,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: AppColors.secondaryColor,
                                  ),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "pass should not be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        title: "LOGIN",
                        // isLoading: formStateLoading,
                        isLoginButton: true,
                        onPressed: () {
                          // submit();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // CustomButton(
              //   title: "CREATE NEW ACCOUNT",
              //   onPressed: () {
              //     goTo(context, RegisterGuardian());
              //   },
              //   // isLoginButton: false,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
