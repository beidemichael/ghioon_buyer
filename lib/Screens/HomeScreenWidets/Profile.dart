import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/ProfileWidgets/SnackBar.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/ProfileWidgets/profileOptionsList.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    double width = MediaQuery.of(context).size.width;
    return userInfo.isEmpty
        ?
      Loading():
         Scaffold(
            // drawer: Drawer(),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text('Store',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 30.0,
                              color: CustomColors().white,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  // excludeHeaderSemantics: true,
                  backgroundColor: CustomColors().blue,
                  // automaticallyImplyLeading: false,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  iconTheme: IconThemeData(color: CustomColors().white)),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const StoreProfile()),
                  //   );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: ,

                      decoration: BoxDecoration(
                        // border: Border.all(width: 1, color: Colors.black),
                        color: CustomColors().blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text('My Store',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 30.0,
                                    color: CustomColors().white,
                                    fontWeight: FontWeight.w600)),
                            Text(userInfo[0].userName,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18.0,
                                    color: CustomColors().white,
                                    fontWeight: FontWeight.w400)),
                            Text('Id: ' + userInfo[0].GhioonId,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: CustomColors().white,
                                    fontWeight: FontWeight.w200)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Account()),
                    //   );
                    // },
                    child: ProfileList(
                        FontAwesomeIcons.solidUser, 'My Account', width)),
                GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const Customers()),
                      // );
                      snackBar(context, 'No Customers yet.', CustomColors().blue, CustomColors().white);
                    },
                    child: ProfileList(
                        FontAwesomeIcons.solidUser, 'Customers', width)),
                GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const Analytics()),
                      // );
                      snackBar(context, 'No Analytics yet.', CustomColors().blue, CustomColors().white);
                    },
                    child: ProfileList(
                        FontAwesomeIcons.chartPie, 'Analytics', width)),
                GestureDetector(
                    onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Marketing()),
                    //   );
                    },
                    child: ProfileList(
                        FontAwesomeIcons.bullhorn, 'Maketing', width)),
                GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const StoreSetting()),
                      // );
                    },
                    child: ProfileList(FontAwesomeIcons.gear, 'Setting', width)),
                GestureDetector(
                    // onTap: () {
                    //   support(context);
                    // },
                    // child: ProfileList(FontAwesomeIcons.solidCircleQuestion,
                    //     'Support', width)
                    ),
              ],
            ),
          ): CircularProgressIndicator(color: CustomColors().blue);
  }
}
