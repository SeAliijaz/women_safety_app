import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/Database-Helper/database_helper.dart';
import 'package:women_safety_app/Models/contacts_model.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/progress_indicator.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/text_form_field.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() {
    return _ContactsScreenState();
  }
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
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    } else {
      return handleInvalidPermissions(permissionStatus);
    }
  }

  getAllContacts() async {
    List<Contact> getContacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = getContacts;
    });
  }

  handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      ShowMessage.flutterToastMsg('Access denied by user');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      ShowMessage.flutterToastMsg("Contacts does'nt exist");
    } else {
      ///Code here
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

  List<Contact> contacts = [];
  List<Contact> contactFilters = [];
  TextEditingController searchController = TextEditingController();

  filterContacts() {
    List<Contact> _contatcs = [];
    _contatcs.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contatcs.retainWhere((element) {
        String searchTerms = searchController.text.toLowerCase();
        String searchTermFlatterned = flattenPhoneNumber(searchTerms);
        String contactName = element.displayName!.toLowerCase();

        bool nameMatched = contactName.contains(searchTerms);
        if (nameMatched == true) {
          return true;
        }
        if (searchTermFlatterned.isEmpty) {
          return false;
        }
        var phone = element.phones!.firstWhere((p) {
          String phoneFlatterned = flattenPhoneNumber(p.value!);
          return phoneFlatterned.contains(searchTermFlatterned);
        });
        return phone.value != null;
      });
    }
    setState(() {
      contactFilters = _contatcs;
    });
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  DataBaseHelper _dataBaseHelper = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemExists = (contactFilters.length > 0 || contacts.length > 0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: contacts.length == 0 ? Text("Loading...") : Text("Contacts"),
      ),
      body: contacts.length == 0
          ? Center(
              child: TitleProgressIndicator(title: "Loading Contacts..."),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: listItemExists == true
                  ? Column(
                      children: [
                        ///Search Field
                        CustomTextField(
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          controller: searchController,
                          labelText: "Search Contacts",
                        ),

                        ///sized box
                        SizedBox(height: 10),

                        ///ListView.builder
                        Expanded(
                          child: ListView.builder(
                            itemCount: isSearching == true
                                ? contactFilters.length
                                : contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              Contact contact = isSearching == true
                                  ? contactFilters[index]
                                  : contacts[index];
                              return ListTile(
                                title: Text(contact.displayName!),
                                leading: contact.avatar != null &&
                                        contact.avatar!.length > 0
                                    ? CircleAvatar(
                                        backgroundImage:
                                            MemoryImage(contact.avatar!),
                                      )
                                    : Text(contact.initials()),
                                onTap: () {
                                  if (contact.phones!.length > 0) {
                                    final String phoneNum =
                                        contact.phones!.elementAt(0).value!;
                                    final String name = contact.displayName!;
                                    _addContact(
                                      ContactModel(phoneNum, name),
                                    );
                                  } else {
                                    ShowMessage.flutterToastMsg(
                                        "phone number of this contact does not exists"
                                            .toUpperCase());
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      child: Text("Searching..."),
                    ),
            ),
    );
  }

  void _addContact(ContactModel contact) async {
    int result = await _dataBaseHelper.insertContact(contact);

    if (result != 0) {
      ShowMessage.flutterToastMsg(
          "${contact.name} is Added to Trusted Contacts");
    } else {
      ShowMessage.flutterToastMsg("Failed To Add ${contact.name}");
    }
    Navigator.of(context).pop(true);
  }
}
