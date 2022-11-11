import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/Constants/constants.dart';
import 'package:women_safety_app/Widgets/web_view_widget.dart';
import '../Utils/quotes.dart';

class CarouselSliderWidget extends StatelessWidget {
  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => route),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;

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
            child: InkWell(
              onTap: (() {
                ///Navigation to WebView
                if (index == 0) {
                  navigateToRoute(context, WebViewWidget(url: webViewURL0));
                } else if (index == 1) {
                  navigateToRoute(context, WebViewWidget(url: webViewURL1));
                } else if (index == 2) {
                  navigateToRoute(context, WebViewWidget(url: webViewURL2));
                } else {
                  navigateToRoute(context, WebViewWidget(url: webViewURL3));
                }
              }),
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
