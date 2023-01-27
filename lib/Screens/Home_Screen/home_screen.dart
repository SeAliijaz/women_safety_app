import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Module-Widgets/emergency_card_widget.dart';
import 'package:women_safety_app/Module-Widgets/live_safe_widget.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/carousel_slider_widget.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/custom_appbar.dart';
import 'package:women_safety_app/Widgets/Location-Bottom_Sheet/location_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Initialization
  int qIndex = 0;

  ///Function to get random quote
  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Women Safety App"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // Routes.goToPage(context, LandingScren());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SafeArea(
          child: Column(
            children: [
              ///Custom App Bar
              ///Where we're showing
              CustomAppBar(
                  quoteIndex: qIndex,
                  onTap: () {
                    getRandomQuote();
                  }),

              Expanded(
                child: ListView(
                  children: [
                    ///Carousel Slider
                    CarouselSliderWidget(),

                    ///Emergency Contact Cards Text
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        "Emergency",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ///Emergency Card Widgetsy
                    EmergencyCardWidget(),

                    ///Explore Live Safe Widget Text
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        "Explore LiveSafe",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ///LiveSafe Widget
                    LiveSafeWidget(),

                    ///Location Send Widget
                    ///Location Bottom Sheet
                    LocationBottomSheet(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
