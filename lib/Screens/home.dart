// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,Catagory_store.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Catagory_screen.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,Dashboard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/5,Profile.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/1,Cart.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/4,Promotion.dart';
import 'package:ghioon_buyer/Screens/update/forced_update.dart';
import 'package:ghioon_buyer/Screens/update/optional_update.dart';
import 'package:ghioon_buyer/Shared/loading.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../Shared/customColors.dart';
import '../Models/models.dart';
import '../Providers/AppInfo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageViewController = PageController(initialPage: 0);
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int activePage = 0;
  int page = 0;
  ///////////////////
  int netVersion = 0;
  /////////////////////////// App version
  int appVersion = 10;
  //////////////////////////  App version
  ///
  optionalUpdateActivator(BuildContext context, netVersionInput) {
    if (netVersionInput == 3 || netVersionInput == 4) {
      OptionalUpdate alert = OptionalUpdate();
 
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      optionalUpdateActivator(context, netVersion);
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);

    final controller = Provider.of<List<VersionController>>(context);
    if (controller.isNotEmpty) {
      netVersion = controller[0].sellerVersion - appVersion;
    }

    return controller.isEmpty
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: CurvedNavigationBar(
              index: 0,
              color: Colors.grey.shade800.withOpacity(0.3),
              buttonBackgroundColor: appInformation.appColor,
              backgroundColor: Colors.white,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              onTap: (index) {
                _pageViewController.animateToPage(index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceOut);
                setState(() {
                  page = index;
                });
              },
              letIndexChange: (index) => true,
              key: _bottomNavigationKey,
              items: <Widget>[
                // SizedBox(
                //   height: 50,
                //   width: 50,
                //   child: Icon(
                //     FontAwesomeIcons.cartShopping,
                //     color: page == 0 ? Colors.white : Colors.grey,
                //   ),
                // ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Icon(
                    FontAwesomeIcons.house,
                    color: page == 0 ? Colors.white : Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Icon(
                    FontAwesomeIcons.list,
                    color: page == 1 ? Colors.white : Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Icon(
                    FontAwesomeIcons.gift,
                    color: page == 2 ? Colors.white : Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Icon(
                    FontAwesomeIcons.solidUser,
                    color: page == 3 ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                PageView(
                  controller: _pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    // const Cart(),
                    Dashboard(context: context),
                    //const CatagoryPage(),
                    Category_Screen(),

                    const PromotionPage(),
                    const Profile(),
                  ],
                ),
                Visibility(
                  visible: netVersion > 4,
                  child: ForcedUpdate(),
                ),
              ],
            ),
          );
  }
}
