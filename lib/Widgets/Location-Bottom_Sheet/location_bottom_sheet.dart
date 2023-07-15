import 'package:background_sms/background_sms.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/Utils/constants.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({Key? key}) : super(key: key);

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  late PermissionStatus _permissionStatus;
  Position? _currentPosition;
  String? _currentAddress;
  List<Contact> _selectedContacts = [];

  @override
  void initState() {
    super.initState();
    _checkPermission();
    _getCurrentLocation();
  }

  Future<void> _checkPermission() async {
    _permissionStatus = await Permission.contacts.status;
    if (_permissionStatus.isDenied) {
      _requestPermission();
    }
  }

  Future<void> _requestPermission() async {
    final PermissionStatus status = await Permission.contacts.request();
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _getCurrentLocation() async {
    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
      _getAddressFromLatLng();
    });
  }

  Future<void> _getAddressFromLatLng() async {
    if (_currentPosition != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      Placemark place = placemarks.first;
      setState(() {
        _currentAddress =
            '${place.locality}, ${place.postalCode}, ${place.street}';
      });
    }
  }

  ///send sms
  _sendSMS(String phoneNumber, String message, {int? simSlot}) async {
    await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: simSlot,
    ).then((SmsStatus status) {
      if (status == "sent") {
        ShowMessage.flutterToastMsg("Message Sent");
      } else {
        ShowMessage.flutterToastMsg("Message Failed");
      }
    });
  }

  void _sendAlert() async {
    if (_currentPosition != null && _currentAddress != null) {
      final List<String> contactList = _selectedContacts
          .map((contact) => contact.phones?.first.value ?? '')
          .toList();
      final String locationURL =
          "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
      final String messageBody =
          'I am in trouble! Please help!\nLocation: $_currentAddress\n$locationURL';

      for (final String contact in contactList) {
        _sendSMS(contact, messageBody);
      }

      print('Alert sent!');
    } else {
      print('Unable to send alert. Location information is missing.');
    }
  }

  Future<void> _selectContacts() async {
    if (_permissionStatus.isGranted) {
      Contact? contact = await ContactsService.openDeviceContactPicker();
      if (contact != null) {
        setState(() {
          _selectedContacts = [contact];
        });
      }
    } else {
      ShowMessage.flutterToastMsg("Permission to access contacts is denied");
      print('Permission to access contacts is denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SEND YOUR CURRENT LOCATION IMMEDIATELY TO YOUR EMERGENCY CONTACTS',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_currentPosition != null) Text((_currentAddress ?? '')),
                    ElevatedButton(
                      onPressed: _getCurrentLocation,
                      child: const Text('GET LOCATION'),
                    ),
                    ElevatedButton(
                      onPressed: _selectContacts,
                      child: const Text('SELECT CONTACTS'),
                    ),
                    ElevatedButton(
                      onPressed: _sendAlert,
                      child: const Text('SEND ALERT'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: const BoxDecoration(),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    ListTile(
                      title: Text('Send Location'),
                      subtitle: Text('Share Location'),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset('assets/route.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
