import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/Utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  Function? onTap;
  int? quoteIndex;
  CustomAppBar({
    Key? key,
    required this.onTap,
    this.quoteIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Card(
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Center(
            child: Text(
              sweetSayings[quoteIndex!],
              textAlign: TextAlign.center,
              style: GoogleFonts.salsa(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
