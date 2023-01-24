import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenSize {
  ScreenWidth(context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  ScreenHeight(context) {
    double height = MediaQuery.of(context).size.height;
    return height;
  }
}
