import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.height, required this.message})
      : super(key: key);

  final double height;
  final String message;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.2),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: height / 4,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFadingCube(
                  color: CustomColors().blue,
                  size: 50.0,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  message,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: CustomColors().blue),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
