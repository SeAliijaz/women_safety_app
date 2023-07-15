import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Chat-Module/chat_screen.dart';
import 'package:women_safety_app/Utils/constants.dart';

class GuardianHomeScreen extends StatelessWidget {
  const GuardianHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("SELECT CHILD".toUpperCase()),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('type', isEqualTo: 'child')
            .where('guardiantEmail',
                isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CustomProgessIndicator.indicator(context));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final value = snapshot.data!.docs[index];
              return Container(
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Routes.goToPage(
                          context,
                          ChatScreen(
                            currentUserId:
                                FirebaseAuth.instance.currentUser!.uid,
                            friendId: value.id,
                            friendName: value["name"],
                          ));
                    },
                    title: Text(value['name']),
                    subtitle: Text(value['type']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
