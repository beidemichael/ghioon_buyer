import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Profile/SettingPages/aboutUs.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Profile/setting.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Models/models.dart';
import '../../Shared/customColors.dart';
import '../../Shared/loading.dart';
import '../components/SnackBar.dart';
import '../components/storeList.dart';
import 'Profile/Account.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    double width = MediaQuery.of(context).size.width;
    return userInfo.isEmpty
        ? Loading()
        : Scaffold(
            // drawer: Drawer(),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text('Profile',
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
                  shape: const RoundedRectangleBorder(
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const StoreProfile()),
                    // );
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: CustomColors().darkBlue,
                                  // border:
                                  //     Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: userInfo[0].image != ''
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          //image
                                          width: 149,
                                          height: 149,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                          ),
                                          child: userInfo[0].image != ''
                                              ? ClipRRect(
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: userInfo[0].image,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Center(
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors.grey[
                                                                        300]!),
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                )
                                              : Center(
                                                  child: Icon(
                                                    Icons.newspaper_rounded,
                                                    size: 10,
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                        ),
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.userLarge,
                                        size: 80.0,
                                        color: Colors.white,
                                      )),
                            Text(userInfo[0].userName,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22.0,
                                    color: CustomColors().white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Account()),
                      );
                    },
                    child: StoreList(
                        FontAwesomeIcons.solidUser, 'My Account', width)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileSetting()),
                      );
                    },
                    child: StoreList(FontAwesomeIcons.gear, 'Setting', width)),
                GestureDetector(
                    onTap: () {
                      // support(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUs()),
                      );
                    },
                    child: StoreList(
                        FontAwesomeIcons.solidCircleQuestion, 'About', width)),
                GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop();
                    },
                    child: StoreList(
                        FontAwesomeIcons.rightFromBracket, 'Logout', width)),
              ],
            ),
          );
  }
}
