import 'package:flutter/material.dart';
import 'package:women_safety_app/Widgets/Emergencies_Widgets/ambulance_emergency_widget.dart';
import 'package:women_safety_app/Widgets/Emergencies_Widgets/army_emergency_widget.dart';
import 'package:women_safety_app/Widgets/Emergencies_Widgets/fire_brigadier_emergency_widget.dart';
import 'package:women_safety_app/Widgets/Emergencies_Widgets/police_emergency_widget.dart';

class EmergencyCardWidget extends StatelessWidget {
  const EmergencyCardWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    return Container(
      height: 180,
      width: s.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FireBrigadierEmergency(),
          ArmyEmergency(),
        ],
      ),
    );
  }
}
