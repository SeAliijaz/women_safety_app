import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Guardian-Module/guardian_home_screen.dart';
import 'package:women_safety_app/Screens/Credientals-Screens/Guardian-Module/register_guardian.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/custom_button.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

class GuardianLogInScreen extends StatefulWidget {
  const GuardianLogInScreen({Key? key}) : super(key: key);
  @override
  State<GuardianLogInScreen> createState() => _GuardianLogInScreenState();
}

class _GuardianLogInScreenState extends State<GuardianLogInScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool ispassword = true;

  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              // CustomButton(
              //   title: 'CLOSE',
              //   onPress: () {
              //     Navigator.pop(context);
              //   },
              // ),
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: emailC.text, password: passwordC.text);

        print("Login Sucessfull");
        _firestore.collection('users').doc(_auth.currentUser!.uid).get().then(
            (value) => userCredential.user!.updateDisplayName(value['name']));
        if (userCredential != null) {
          setState(() {
            formStateLoading = false;
          });

          _firestore
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .get()
              .then((value) {
            if (value['status'] == true) {
              ecoDialogue('user may have been deleted');
            } else {
              // MySharedPreferences.saveEmail(emailC.text);
              Routes.goTo(context, GuardianHomeScreen());
            }
          });

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => GuardianHomeScreen()));
        }

        return userCredential.user;
      } catch (e) {
        ecoDialogue(e.toString());
        print(e);
        return null;
      }
    }
  }

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;
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
                "Guardian Login",
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
                                URLClass.guardianImage),
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
                            Icons.mail,
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
                          isPassword: ispassword,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.secondaryColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                ispassword = !ispassword;
                              });
                            },
                            icon: ispassword
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
                          submit();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                title: "CREATE NEW ACCOUNT",
                onPressed: () {
                  Routes.goTo(context, RegisterGuardian());
                },
                isLoginButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
