import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/progress_indicator.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      return getAllContacts();
    } else {
      return handleInvalidPermissions(permissionStatus);
    }
  }

  List<Contact> contacts = [];
  getAllContacts() async {
    List<Contact> getContacts = await ContactsService.getContacts();
    setState(() {
      contacts = getContacts;
    });
  }

  handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      return showMessage('Access denied by user');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      return showMessage("Contacts does'nt exist");
    } else {
      ///Empty for now
    }
  }

  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: contacts.length == 0 ? Text("Loading...") : Text("Contacts"),
      ),
      body: contacts.length == 0
          ? Center(
              child: CustomProgressIndicator(title: "Loading your Contacts..."),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contact value = contacts[index];
                return ListTile(
                  leading: value.avatar != null && value.avatar!.length > 0
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(value.avatar!),
                        )
                      : Text(value.initials()),
                  title: Text(value.displayName!),
                );
              },
            ),
    );
  }
}
