// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

class BlueButton extends StatelessWidget {
  String text;
  BlueButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 60,
      decoration: BoxDecoration(
        color: CustomColors().blue,
        // border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                fontSize: 21.0,
                color: CustomColors().white,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class BlueButtonWhite extends StatelessWidget {
  String text;
  BlueButtonWhite({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 60,
      decoration: BoxDecoration(
        color: CustomColors().white,
        // border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                fontSize: 21.0,
                color: CustomColors().blue,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
