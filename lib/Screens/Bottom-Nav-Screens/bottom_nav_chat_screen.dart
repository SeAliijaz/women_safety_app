import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

class BottomNavChatScreen extends StatelessWidget {
  const BottomNavChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Select Guardian'.toUpperCase()),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("type", isEqualTo: "parent")
            .where("childEmail",
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
              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: () {},
                  leading: Icon(Icons.chat_bubble_outline),
                  title: Text(value["name"]),
                  subtitle: Text("Type: ${value["type"]}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
