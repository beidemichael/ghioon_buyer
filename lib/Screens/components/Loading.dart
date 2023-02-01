import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../Providers/AppInfo.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);
    return Scaffold(
      body: Center(
          child: SpinKitCircle(
        color: appInformation.appColor,
        size: 50.0,
      )),
    );
  }
}
