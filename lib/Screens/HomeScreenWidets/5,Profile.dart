import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/4,Promotion/promotion_demo.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/5,Profile/SettingPages/aboutUs.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/5,Profile/setting.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Models/models.dart';
import '../../Shared/customColors.dart';
import '../../Shared/loading.dart';
import '../components/SnackBar.dart';
import '../components/storeList.dart';
import '5,Profile/Account.dart';
import '5,Profile/ProfileWidgets/DeliveryAddresses/Delivery_Address.dart';
import '5,Profile/SettingPages/LogOut.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  _showLogoutDialog(BuildContext context) {
    VoidCallback okCallBack = () => {
          // Navigator.of(context).pop(),
        };
    LogOutMessage alert = LogOutMessage();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    var languageprov = Provider.of<LanguageProvider>(context);
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
                      Text(Language().profile[languageprov.LanguageIndex],
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: Dimensions.font26,
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
                                    fontSize: Dimensions.font23,
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
                        FontAwesomeIcons.solidUser,
                        Language().my_account[languageprov.LanguageIndex],
                        width)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const deliveryaddress()),
                      );
                    },
                    child: StoreList(
                        FontAwesomeIcons.locationDot,
                        Language().saved_address[languageprov.LanguageIndex],
                        width)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileSetting()),
                      );
                    },
                    child: StoreList(FontAwesomeIcons.gear,
                        Language().setting[languageprov.LanguageIndex], width)),
                GestureDetector(
                    onTap: () {
                      // support(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUs()),
                      );
                    },
                    child: StoreList(FontAwesomeIcons.solidCircleQuestion,
                        Language().about[languageprov.LanguageIndex], width)),
                GestureDetector(
                    onTap: () async {
                      _showLogoutDialog(context);
                    },
                    child: StoreList(FontAwesomeIcons.rightFromBracket,
                        Language().logout[languageprov.LanguageIndex], width)),
                // GestureDetector(
                //     onTap: () async {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => PromotionsPage()),
                //       );
                //     },
                //     child: StoreList(
                //         FontAwesomeIcons.rightFromBracket, "promo", width)),
              ],
            ),
          );
  }
}
