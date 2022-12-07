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
      final VoidCallback? onTap,
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
          onTap: onTap,
        ),
      );
    }

    final Size s = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("Edit Profile"),
        ),
        body: SafeArea(
          child: SizedBox(
            height: s.height,
            width: s.width,
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
                    backgroundImage: NetworkImage(profilePic),
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
                          onPressed: () {},
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
                    onTap: () {},
                  ),
                  listTile(
                    leadingIcon: Icons.mail,
                    titleText: "Email",
                    subTitleText: "Ali@gmail.com",
                    trailingIcon: Icons.edit,
                    onTap: () {},
                  ),
                  listTile(
                    leadingIcon: Icons.phone,
                    titleText: "Phone",
                    subTitleText: "0309-4991850",
                    trailingIcon: Icons.edit,
                    onTap: () {},
                  ),
                  listTile(
                    leadingIcon: Icons.phonelink_off,
                    titleText: "Logout",
                    trailingIcon: Icons.exit_to_app,
                    onTap: () {},
                  ),

                  ///SizedBox
                  SizedBox(height: 20),

                  MaterialButton(
                    height: s.height * 0.070,
                    elevation: 5,
                    splashColor: const Color.fromARGB(255, 158, 158, 158)
                        .withOpacity(0.5),
                    minWidth: s.width,
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
