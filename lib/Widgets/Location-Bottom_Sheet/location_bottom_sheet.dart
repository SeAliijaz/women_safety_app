import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/Database-Helper/database_helper.dart';
import 'package:women_safety_app/Models/contacts_model.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Buttons/custom_button.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  ///Get Permission
  _getPermission() async => await [Permission.sms].request();

  ///Permisison Granted
  _isPermissionGranted() async => await [Permission.sms.status.isGranted];

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

  ///Bottom Sheet to send location
  showLocationBottomSheet(BuildContext context) {
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
              )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SEND YOUR CUURENT LOCATION IMMEDIATELY TO YOU EMERGENCY CONTACTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
                SizedBox(height: 10),
                if (_currentPosition != null) Text(_currentAddress!),
                CustomButton(
                  title: "GET LOCATION",
                  isLoginButton: true,
                  onPressed: _getCurrentLocation,
                ),
                CustomButton(
                  title: "Send Alert",
                  isLoginButton: true,
                  onPressed: () async {
                    List<ContactModel> contactList =
                        await DataBaseHelper().getContactList();
                    String receipents = "";
                    int iteration = 1;
                    for (ContactModel contactModel in contactList) {
                      receipents += contactModel.number;
                      if (iteration != contactList.length) {
                        receipents += "+";
                        iteration++;
                      }
                    }
                    String locationURL =
                        "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}. $_currentAddress";
                    String messageBody = locationURL;
                    if (await _isPermissionGranted()) {
                      contactList.forEach((element) {
                        _sendSMS(element.number,
                            "I'm in Trouble Please Help My Location: $messageBody");
                      });
                    } else {
                      ShowMessage.flutterToastMsg("something wrong");
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _currentAddress;
  Position? _currentPosition;
  LocationPermission? _locationPermission;

  ///Get Location
  _getCurrentLocation() async {
    _locationPermission = await Geolocator.checkPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
      ShowMessage.flutterToastMsg("Location permissions are  denind");
      if (_locationPermission == LocationPermission.deniedForever) {
        ShowMessage.flutterToastMsg(
            "Location permissions are permanently denind");
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      ShowMessage.flutterToastMsg(e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      ShowMessage.flutterToastMsg(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showLocationBottomSheet(context),
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
                    title: Text("Send Location"),
                    subtitle: Text("Share Location"),
                  ),
                ],
              )),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/route.jpg')),
            ],
          ),
        ),
      ),
    );
  }
}
