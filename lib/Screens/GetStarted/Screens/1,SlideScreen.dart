import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Screens/GetStarted/Screens/ScreenTemplate.dart';
import 'package:ghioon_buyer/Screens/GetStarted/Screens/2,FinalScreen.dart';

import '../Widgets/SlideDots.dart';

class SlideScreen extends StatefulWidget {
  const SlideScreen({super.key});

  @override
  State<SlideScreen> createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<Widget> slideList = [
    ScreenTemplate(
        title1: 'Discover our',
        title2: 'NEW PRODUCTS',
        title3: 'Explore our online shopping experience',
        image: 'assets/undraw_product_photography_91i2.png'),
    ScreenTemplate(
        title1: 'Comfortable and',
        title2: 'EASY CHECKOUT',
        title3: 'Safe and easy payment',
        image: 'assets/undraw_shopping_app_flsj.png'),
    ScreenTemplate(
        title1: 'Reliable and',
        title2: 'FAST DELIVERY',
        title3: 'Order and forget experience',
        image: 'assets/undraw_Delivery_address_re_cjca.png'),
    FinalScreen()
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 5), (Timer timer) {
  //     if (_currentPage < 2) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }

  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeIn,
  //     );
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      children: slideList),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 35),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < slideList.length; i++)
                              if (i == _currentPage)
                                SlideDots(true)
                              else
                                SlideDots(false)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
