// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Catagory.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Dashboard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Profile.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Cart.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/Promotion.dart';
import 'package:ghioon_buyer/Shared/loading.dart';

import 'package:provider/provider.dart';

import '../../Shared/customColors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageViewController = PageController();

  int _activePage = 2;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  ///////////////////
  int netVersion = 0;
  /////////////////////////// App version
  int appVersion = 1;
  //////////////////////////  App version
  ///
  ///
  // optionalUpdateActivator(BuildContext context, netVersionInput) {
  //   if (netVersionInput == 3 || netVersionInput == 4) {
  //     OptionalUpdate alert = OptionalUpdate();

  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return alert;
  //       },
  //     );
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration(seconds: 4), () {
  //     optionalUpdateActivator(context, netVersion);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final controller = Provider.of<List<Controller>>(context);
    // if (controller.isNotEmpty) {
    //   netVersion = controller[0].sellerVersion - appVersion;
    // }

    return
        // controller.isEmpty
        //     ? Loading()
        //     :
        Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        iconSize: 25,
        selectedLabelStyle: TextStyle(
            fontSize: 13.0,
            color: CustomColors().blue,
            fontWeight: FontWeight.w600),
        elevation: 5,
        selectedItemColor: CustomColors().blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _activePage,
        onTap: (index) {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceOut);
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.list),
            label: 'Catagory',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Dashboard',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.gift),
            label: 'Promotion',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageViewController,
            children: const <Widget>[
              Cart(),
              Catagory(),
              Dashboard(),
              Promotion(),
              Profile(),
            ],
            onPageChanged: (index) {
              setState(() {
                _activePage = index;
              });
            },
          ),
          // Visibility(
          //   visible: netVersion > 4,
          //   child: ForcedUpdate(),
          // ),
        ],
      ),
    );
  }
}
