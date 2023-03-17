// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/RangeProvider.dart';

import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/ProductForGrid.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:ghioon_buyer/Services/Database/Product/readProduct.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

import 'package:provider/provider.dart';

import 'Store_profile_components/StoreImages.dart';
import 'Store_profile_components/collection/collectionListGrid.dart';

class StoreProfile extends StatefulWidget {
  StoreProfile({super.key});

  @override
  State<StoreProfile> createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    final sellers = Provider.of<List<SellerInformation>>(context);
    final appState = Provider.of<RangeData>(context);
    final products = Provider.of<List<Product>>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final appState = Provider.of<RangeData>(context);

    return DefaultTabController(
      length: 2,
      child: sellers.isEmpty
          ? Loading()
          : Scaffold(
              // drawer: Drawer(),
              appBar: AppBar(
                  centerTitle: true,
                  // toolbarHeight: 250,
                  title: Text(sellers[0].businessName, //'Endale Abegazee',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: CustomColors().white,
                          fontWeight: FontWeight.w500)),
                  excludeHeaderSemantics: true,
                  backgroundColor: CustomColors().blue,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.white)),
              body: ListView(
                children: [
                  detailTab(sellers[0]),
                  sellers[0].profileImages.isNotEmpty
                      ? StoreImagesList(seller: sellers[0])
                      : Container(),
                  TabBar(
                      indicatorColor: CustomColors().blue,
                      indicatorWeight: 6,
                      tabs: <Tab>[
                        Tab(
                          child: Text('Products',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Tab(
                          child: Text('Categories',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: TabBarView(
                      children: [
                        products.length == 0
                            ? EmptyScreen(context, 'No Products.')
                            : StreamProvider<List<Product>>.value(
                                initialData: [],
                                value: ReadProductDatabaseService(
                                  userUid: sellers[0].userUid,
                                ).readSellerProduct,
                                child: ProductForGrid()),
                        sellers[0].collections == 0
                            ? EmptyScreen(context, 'No Collections')
                            : CollectionListGrid(
                                sellers: sellers, appState: appState),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  detailTab(sellers) {
    return Container(
      height: 50,
      width: ScreenSize().ScreenWidth(context),
      color: CustomColors().blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.visibility,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    sellers.viewCountTime.length.toString(),
                    //'25',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              )),
            ),
            Expanded(
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    sellers.rating.toString(), //'4.5',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
