import 'dart:math';

import 'package:flutter/material.dart';
import 'package:women_safety_app/Widgets/custom_appbar.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            ///Custom App Bar
            ///Where we're showing Quotes
            CustomAppBar(
                quoteIndex: qIndex,
                onTap: () {
                  getRandomQuote();
                })
          ],
        ),
      ),
    );
  }
}
