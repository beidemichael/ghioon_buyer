// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Shared/customColors.dart';

Widget StoreList(IconData icon, String name, double width) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  icon,
                  color: CustomColors().blue,
                  size: 20,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(name,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Icon(
              FontAwesomeIcons.angleRight,
              color: CustomColors().blue,
              size: 20,
            ),
          ],
        ),
      ),
    ),
  );
}
