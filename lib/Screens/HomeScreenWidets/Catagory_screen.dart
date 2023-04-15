// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/Catagory_product.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/Catagory_store.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:provider/provider.dart';

import '../../Models/models.dart';
import '../../Shared/customColors.dart';
import '../../Shared/loading.dart';
import '../../Providers/AppInfo.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Shared/language.dart';

class Category_Screen extends StatefulWidget {
  const Category_Screen({super.key});

  @override
  State<Category_Screen> createState() => _Category_ScreenState();
}

class _Category_ScreenState extends State<Category_Screen> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
   
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appInformation = Provider.of<AppInformation>(context);
    final catagory = Provider.of<List<Category>>(context);
    var languageprov = Provider.of<LanguageProvider>(context);
    final upperTab =
        TabBar(indicatorColor: Colors.white, indicatorWeight: 3, tabs: <Tab>[
      Tab(
        child: Text( Language().store[languageprov.LanguageIndex],
            style: TextStyle(
                fontSize: Dimensions.font14,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
      Tab(
        child: Text( Language().products[languageprov.LanguageIndex],
            style: TextStyle(
                fontSize: Dimensions.font14,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
      
    ]);
    return
    //  userInfo.isEmpty
    //     ? Loading()
    //     : 
        DefaultTabController(
            length: 2,
            child: Scaffold(
              // drawer: Drawer(),
              appBar: AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                       Text(
                       Language().categories[languageprov.LanguageIndex],
                        style: TextStyle(
                            fontSize: Dimensions.font26,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  excludeHeaderSemantics: true,
                  backgroundColor: CustomColors().blue,
                  elevation: 3,
                  bottom: upperTab,
                  iconTheme: const IconThemeData(color: Colors.white)),
              body: TabBarView(
                children: [
                  CatagoryPage(),
                  CatagoryProductPage(),
                 
                ],
              ),
            ),
          );
  }
}


