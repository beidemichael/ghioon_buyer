// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Catagory.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Dashboard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Profile.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Cart.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Promotion.dart';
import 'package:ghioon_buyer/Shared/loading.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../Shared/customColors.dart';
import '../Providers/AppInfo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageViewController = PageController();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _activePage = 2;
  int _page = 0;
  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        color: appInformation.appColor,
        buttonBackgroundColor: appInformation.appColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceOut);
          // setState(() {
        },
        letIndexChange: (index) => true,
        key: _bottomNavigationKey,
        items: const <Widget>[
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              FontAwesomeIcons.cartShopping,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              FontAwesomeIcons.list,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              FontAwesomeIcons.house,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              FontAwesomeIcons.gift,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              FontAwesomeIcons.solidUser,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageViewController,
            physics: const NeverScrollableScrollPhysics(),
            children: const <Widget>[
              Cart(),
              Catagory(),
              Dashboard(),
              Promotion(),
              Profile(),
            ],
          ),
        ],
      ),
    );
  }
}
