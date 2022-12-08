import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 5.0),
              color: Colors.grey[300],
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      showMessage("Will go back");
                    },
                  ),
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(profilePic),
                      ),
                      border: Border.all(
                        color: const Color(0xff025f7f),
                        width: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Muhammad Ali',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff025f7f),
                        ),
                      ),
                      Text(
                        'Active Now',
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.phone,
                      color: Color(0xff025f7f),
                    ),
                    onPressed: () {
                      showMessage("Calling");
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.info,
                      color: Color(0xff025f7f),
                    ),
                    onPressed: () {
                      showMessage("User Info");
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              height: 3.0,
              color: Color(0xff025f7f),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return index % 2 == 0
                        ? Container(
                            margin: EdgeInsets.fromLTRB(
                                2.5, 2.5, size.width * 0.3, 2.5),
                            width: size.width * 0.65,
                            child: Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              profilePic),
                                        ),
                                        border: Border.all(
                                          color: const Color(0xff025f7f),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    SizedBox(
                                      width: size.width * 0.65 - 43.0,
                                      child: const Text(
                                        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum tenetur error, harum nesciunt ipsum debitis quas aliquid.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(fontSize: 13.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.fromLTRB(
                                size.width * 0.3, 2.5, 2.5, 2.5),
                            width: size.width * 0.65,
                            child: Card(
                              color: Colors.blue[50],
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum tenetur error, harum nesciunt ipsum debitis quas aliquid.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 13.5),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: [
                  const SizedBox(width: 8.0),
                  Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(profilePic),
                      ),
                      border: Border.all(
                        color: const Color(0xff025f7f),
                        width: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: TextField(
                        style: const TextStyle(fontSize: 14.0),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: const TextStyle(fontSize: 14.0),
                          suffixIcon: IconButton(
                            icon:
                                const Icon(Icons.mic, color: Color(0xff025f7f)),
                            onPressed: () => showMessage('Mic Pressed'),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Color(0xff025f7f),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  InkWell(
                    child: const Icon(
                      Icons.add,
                      color: Color(0xff025f7f),
                    ),
                    onTap: () async => await showBottomSheetOptions(context),
                  ),
                  const SizedBox(width: 5.0),
                  InkWell(
                    child: const Icon(
                      Icons.send,
                      color: Color(0xff025f7f),
                    ),
                    onTap: () {
                      showMessage("msg sent");
                    },
                  ),
                  const SizedBox(width: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showBottomSheetOptions(BuildContext context) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  onPressed: () => showMessage("Will update later."),
                  color: const Color(0xff025f7f),
                  textColor: Colors.white,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 24,
                  ),
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Camera",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  onPressed: () => showMessage("Will update later."),
                  color: const Color(0xff025f7f),
                  textColor: Colors.white,
                  child: const Icon(
                    Icons.photo,
                    size: 24,
                  ),
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  onPressed: () => showMessage("Will update later."),
                  color: const Color(0xff025f7f),
                  textColor: Colors.white,
                  child: const Icon(
                    Icons.assignment_rounded,
                    size: 24,
                  ),
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Document",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
