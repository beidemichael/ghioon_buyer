// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,Catagory.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,Dashboard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/5,Profile.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/1,Cart.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/4,Promotion.dart';
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
  final _pageViewController = PageController(initialPage: 2);
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int activePage = 2;
  int page = 2;
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
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              FontAwesomeIcons.cartShopping,
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
              FontAwesomeIcons.house,
              color: page == 2 ? Colors.white : Colors.grey,
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              FontAwesomeIcons.gift,
              color: page == 3 ? Colors.white : Colors.grey,
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(
              FontAwesomeIcons.solidUser,
              color: page == 4 ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageViewController,
            physics: const NeverScrollableScrollPhysics(),
            children:  <Widget>[
              const Cart(),
              const CatagoryPage(),
              Dashboard(context: context),
              const Promotion(),
              const Profile(),
            ],
          ),
        ],
      ),
    );
  }
}
