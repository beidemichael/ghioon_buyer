import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Screens/home.dart';

import 'package:provider/provider.dart';

import '../../../Models/models.dart';
import '../../../Services/Database/User/userDatabase.dart';
import '../SignInScreens/0,SignInPage.dart';
import 'CheckRegisteration.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

    return StreamProvider<List<UserInformation>>.value(
        value: UserDatabaseService(userUid: user?.uid).userInfo,
        initialData: const [],
        child: user == null
            ? SignInPage()
            :  CheckRegisteration());
  }
}
