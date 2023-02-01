import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    var items = [Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
            color: CustomColors().white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 42.0,
                backgroundImage: AssetImage('assets/Logo.png'),
                backgroundColor: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "hello",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ))),
    ),Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
            color: CustomColors().white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 42.0,
                backgroundImage: AssetImage('assets/Logo.png'),
                backgroundColor: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "hey",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ))),
    )];
    return CarouselSlider(
                items: items,
                options: CarouselOptions(
                  height: ScreenSize().ScreenHeight(context) * 0.25,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.85,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.decelerate,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,

                  //onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ));
  }
}