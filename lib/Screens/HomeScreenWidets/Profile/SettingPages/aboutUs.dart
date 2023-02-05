import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:ghioon_buyer/Shared/terms_condition.dart';


class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('About US',
                    style: TextStyle(
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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: CustomColors().blue),
            color: CustomColors().white,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/Logo.png',
                    //   width: 100,
                    // ),
                    // CircleAvatar(
                    //   backgroundColor: Colors.blue,
                    //   radius: 80,
                    //   child: Image.asset(
                    //     'assets/splash3.png',
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundImage: AssetImage('assets/Logo.png'),
                        //NetworkImage('https://via.placeholder.com/150'),
                        backgroundColor: Colors.transparent,
                        // backgroundColor: CustomColors().grey
                        // backgroundImage: Image.asset('assets/post.jpg'),
                      ),
                    ),

                    Text(AboutUsText().p1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Inter',
                          color: CustomColors().black,
                        ))
                  ])),
        ),
      ),
    );
  }
}
