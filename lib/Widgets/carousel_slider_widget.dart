import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../Utils/quotes.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    Key? key,
    required this.s,
  }) : super(key: key);

  final Size s;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CarouselSlider(
        items: List.generate(carouselImages.length, (index) {
          return Card(
            elevation: 5,
            shadowColor: Colors.grey[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: s.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    carouselImages[index],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      articleTexts[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: s.width * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        options: CarouselOptions(
          aspectRatio: 2.0,
          autoPlay: true,
        ),
      ),
    );
  }
}
