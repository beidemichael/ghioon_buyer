// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../Models/models.dart';
import '../../home.dart';
import '../SignInScreens/1,Register.dart';


class CheckRegisteration extends StatelessWidget {
  const CheckRegisteration({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);

    return Scaffold(
      // ignore: unnecessary_null_comparison
      body: userInfo == null
          ? const Center(
              child: SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            ))
          : userInfo.isEmpty
              ?  Register()
              : const HomeScreen(),
                  
    );
  }
}
