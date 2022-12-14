import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ///Widget ListTile
    Widget listTile({
      final IconData? leadingIcon,
      final String? titleText,
      final String? subTitleText,
      final IconData? trailingIcon,
    }) {
      return Card(
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textColor: Colors.black,
          leading: Icon(leadingIcon ?? Icons.edit),
          title: Text(titleText ?? ""),
          subtitle: Text(subTitleText ?? ""),
          trailing: Icon(trailingIcon ?? Icons.abc),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("Edit Profile"),
        ),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuerySize(context).height,
            width: MediaQuerySize(context).width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: Column(
                children: [
                  ///Profile Pic
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.grey[500],
                    backgroundImage:
                        CachedNetworkImageProvider(URLClass().profilePic),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            ShowMessages()
                                .message("feature will be added soon!");
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///SizedBox
                  SizedBox(height: 20),

                  ///ListTiles
                  listTile(
                    leadingIcon: Icons.person,
                    titleText: "Name",
                    subTitleText: "Muhammad Ali",
                    trailingIcon: Icons.edit,
                  ),
                  listTile(
                    leadingIcon: Icons.mail,
                    titleText: "Email",
                    subTitleText: "Ali@gmail.com",
                    trailingIcon: Icons.edit,
                  ),
                  listTile(
                    leadingIcon: Icons.phone,
                    titleText: "Phone",
                    subTitleText: "0309-4991850",
                    trailingIcon: Icons.edit,
                  ),
                  listTile(
                    leadingIcon: Icons.logout,
                    titleText: "Logout",
                    subTitleText: "As a UserType",
                    trailingIcon: Icons.arrow_forward_ios,
                  ),

                  ///SizedBox
                  SizedBox(height: 20),

                  MaterialButton(
                    height: MediaQuerySize(context).height * 0.070,
                    elevation: 10,
                    splashColor: const Color.fromARGB(255, 158, 158, 158)
                        .withOpacity(0.5),
                    minWidth: MediaQuerySize(context).width / 1.05,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: primaryColor,
                    child: Text(
                      "Save Info",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
