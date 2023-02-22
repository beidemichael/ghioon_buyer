import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:ghioon_buyer/Shared/terms_condition.dart';


class Terms extends StatelessWidget {
  const Terms({super.key});

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
                  Text('Terms and conditions',
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
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              title(TermsData().title1),
              paragraph(TermsData().p1),
              title(TermsData().title2),
              paragraph(TermsData().p2),
              paragraph(TermsData().p3),
              paragraph(TermsData().p5),
              paragraph(TermsData().p5),
              paragraph(TermsData().p6),
              paragraph(TermsData().p7),
              paragraph(TermsData().p8),
            ],
          ),
        ));
  }

  Padding title(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding paragraph(String paragraoh) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(paragraoh,
          style: TextStyle(
            fontSize: 16,
          )),
    );
  }
}
