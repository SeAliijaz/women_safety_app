import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/contacts_screen.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/custom_button.dart';

class AddTrustedContacts extends StatelessWidget {
  const AddTrustedContacts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomButton(
              title: "Add Trusted Contacts",
              isLoginButton: true,
              onPressed: () {
                RoutesAndIndicators().goTo(context, ContactsScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
