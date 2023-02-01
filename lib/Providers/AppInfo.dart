import 'package:flutter/foundation.dart';
import 'dart:ui';

class AppInformation with ChangeNotifier {
  String appName = 'Ghioon';
  // Color appColor = Color.fromARGB(255, 201, 0, 0);
  Color appColor = Color(0xff4DC5DF);
  Color appColorDark = const Color.fromARGB(255, 48, 170, 0);
  Color appColorLight = const Color(0xFF11C900).withOpacity(0.2);
  String appCurrency = 'ETB';
}
// class CustomColors {
//   Color blue = const Color(0xff4DC5DF);
//   Color lightBlue = const Color.fromARGB(255, 173, 240, 255);
//   Color superLightBlue = const Color(0xffE3FBFF);
//   Color darkBlue = const Color.fromARGB(255, 90, 180, 201);
  Color white = Color(0xFFFFFFFF);
//   Color black = const Color.fromARGB(255, 0, 0, 0);
//   Color red = const Color.fromARGB(255, 255, 0, 0);
//   Color grey = const Color.fromARGB(126, 102, 102, 102);
//   Color lightgrey = const Color.fromARGB(125, 200, 199, 199);
// }
