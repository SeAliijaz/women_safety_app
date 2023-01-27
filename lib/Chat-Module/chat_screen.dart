import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Chat-Screen-Widgets/chat_text_field.dart';
import '../Widgets/Chat-Screen-Widgets/single_message_widget.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;

  const ChatScreen(
      {super.key,
      required this.currentUserId,
      required this.friendId,
      required this.friendName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? type;
  String? myname;

  getStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUserId)
        .get()
        .then((value) {
      setState(() {
        type = value.data()!['type'];

        myname = value.data()!['name'];
      });
    });
  }

  @override
  void initState() {
    getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(widget.friendName),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.currentUserId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .collection('chats')
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length < 1) {
                      return Center(
                        child: Text(
                          type == "parent"
                              ? "TALK WITH CHILD"
                              : "TALK WITH PARENT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return Container(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isMe = snapshot.data!.docs[index]['senderId'] ==
                              widget.currentUserId;
                          final data = snapshot.data!.docs[index];
                          return SingleMessageWidget(
                            message: data['message'],
                            date: data['date'],
                            isMe: isMe,
                            friendName: widget.friendName,
                            myName: myname,
                            type: data['type'],
                          );
                        },
                      ),
                    );
                  }
                  return CustomProgessIndicator.indicator(context);
                },
              ),
            ),
            ChatTextField(
              currentId: widget.currentUserId,
              friendId: widget.friendId,
            ),
          ],
        ));
  }
}
