// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Screens/GetStarted/Screens/1,SlideScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../../Models/models.dart';
import '../../../Services/PhoneAuth.dart';
import '../../../Shared/loading.dart';
import '../../SignIn/SignInLogic/wrapper.dart';


class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => StreamProvider<UserAuth?>.value(
          value: PhoneAuthServices().user,
          initialData: null,
          child: Wrapper(),
        ),));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SlideScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Loading(),
    );
  }
}