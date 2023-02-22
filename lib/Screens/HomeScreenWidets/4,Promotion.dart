import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Screens/GetStarted/Screens/1,SlideScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/4,Promotion/PromotionScreens.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';

import '../../Models/models.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  @override
  Widget build(BuildContext context) {
    final promotion = Provider.of<List<Promotion>>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(69.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('Promotion',
                    style: TextStyle(
                        fontSize: 28.0,
                        color: CustomColors().white,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white)),
      ),
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Carousel25(
                    promotion,
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
                Carousel50(
                    promotion,
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
                Carousel100(
                    promotion,
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              ],
            )),
      ),
    );
  }
}
