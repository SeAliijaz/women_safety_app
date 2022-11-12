import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/LiveSafe_Widget/bus_station_location_card.dart';
import 'package:women_safety_app/Widgets/LiveSafe_Widget/hospital_location_card.dart';
import 'package:women_safety_app/Widgets/LiveSafe_Widget/pharmacy_location_card.dart';
import 'package:women_safety_app/Widgets/LiveSafe_Widget/police_station_location_card.dart';

class LiveSafeWidget extends StatelessWidget {
  const LiveSafeWidget({Key? key}) : super(key: key);

  ///Open Map function
  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri link = Uri.parse(googleUrl);
    try {
      await launchUrl(link);
    } catch (e) {
      showMessage('something went wrong! call emergency number');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;

    return Container(
      height: 100,
      width: s.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          PoliceStationCard(onMapFunction: openMap),
          HospitalCard(onMapFunction: openMap),
          PharmacyCard(onMapFunction: openMap),
          BusStationCard(onMapFunction: openMap),
        ],
      ),
    );
  }
}
