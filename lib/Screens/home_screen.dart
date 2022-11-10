import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:women_safety_app/Utils/quotes.dart';
import 'package:women_safety_app/Widgets/carousel_slider_widget.dart';
import 'package:women_safety_app/Widgets/custom_appbar.dart';
import 'package:women_safety_app/Widgets/text_form_field.dart';

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
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
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

              ///Carousel Slider
              CarouselSliderWidget(s: s),
            ],
          ),
        ),
      ),
    );
  }
}
