// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/AppInfo.dart';


class Button extends StatefulWidget {
  String text;
  Button({super.key, required this.text});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);

    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 60,
      decoration: BoxDecoration(
        color: appInformation.appColor,
        // border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Center(
        child: Text(widget.text,
            style: TextStyle(
                fontSize: 21.0,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
