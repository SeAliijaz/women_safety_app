import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:women_safety_app/Database-Helper/database_helper.dart';
import 'package:women_safety_app/Models/contacts_model.dart';
import 'package:women_safety_app/Screens/Bottom-Nav-Screens/contacts_screen.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/custom_button.dart';

class AddTrustedContacts extends StatefulWidget {
  const AddTrustedContacts({super.key});

  @override
  State<AddTrustedContacts> createState() => _AddTrustedContactsState();
}

class _AddTrustedContactsState extends State<AddTrustedContacts> {
  DataBaseHelper databasehelper = DataBaseHelper();
  List<ContactModel>? contactList;
  int count = 0;

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ContactModel>> contactListFuture =
          databasehelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  void deleteContact(ContactModel contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      ShowMessage.flutterToastMsg(
          "Contact ${contact.name} is Removed from Trusted Contacts");
      showList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///for contacts list null
    if (contactList == null) {
      contactList = [];
    }

    ///SafeArea
    return SafeArea(
      child: Column(
        children: [
          CustomButton(
              title: "Add Trusted Contacts",
              isLoginButton: true,
              onPressed: () async {
                bool result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactsScreen(),
                    ));
                if (result == true) {
                  showList();
                }
              }),
          Expanded(
            child: ListView.builder(
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  background: Container(
                    color: AppColors.primaryColor,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  onDismissed: ((direction) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("Are You Sure You Want to Delete?"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    "You want to delete this ${contactList![index].name} Contact?"),
                              ],
                            ),
                            actions: [
                              MaterialButton(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              MaterialButton(
                                color: Colors.green,
                                onPressed: () {
                                  deleteContact(contactList![index]);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        });
                  }),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      iconColor: AppColors.primaryColor,
                      textColor: Colors.black,
                      leading: const Icon(Icons.person),
                      title: Text(
                        contactList![index].name,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(contactList![index].number),
                      trailing: IconButton(
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              contactList![index].number);
                        },
                        icon: const Icon(Icons.call),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
