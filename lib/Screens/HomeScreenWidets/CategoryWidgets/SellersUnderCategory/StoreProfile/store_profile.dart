// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/RangeProvider.dart';

import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductForGrid.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:ghioon_buyer/Services/Database/Product/readProduct.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

import 'package:provider/provider.dart';

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
    const upperTab =
        TabBar(indicatorColor: Colors.white, indicatorWeight: 3, tabs: <Tab>[
      Tab(
        child: Text('Product',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
      Tab(
        child: Text('Collection',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
    ]);
    return DefaultTabController(
      length: 2,
      child: sellers.isEmpty
          ? Loading()
          : Scaffold(
              // drawer: Drawer(),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(300.0),
                child: AppBar(
                    centerTitle: true,
                    toolbarHeight: 250,
                    title: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          100.0), //or 15.0
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: CustomColors().darkBlue,
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        ),
                                        child: sellers[0]
                                                .profileImages
                                                .isNotEmpty
                                            ? CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    sellers[0].profileImages[0],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.grey[
                                                                    300]!),
                                                        value: downloadProgress
                                                            .progress),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )
                                            : Icon(
                                                FontAwesomeIcons.userLarge,
                                                size: 80.0,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                        sellers[0]
                                            .businessName, //'Endale Abegazee',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: CustomColors().white,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              height: 10,
                              thickness: 1,
                              color: CustomColors().white,
                            ),
                            Container(
                              height: 50,
                              width: ScreenSize().ScreenWidth(context),
                              color: CustomColors().blue,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            sellers[0].views.toString(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                            sellers[0]
                                                .rating
                                                .toString(), //'4.5',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      )),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      const SizedBox(
                        width: 50,
                      )
                    ],
                    excludeHeaderSemantics: true,
                    backgroundColor: CustomColors().blue,
                    elevation: 3,
                    bottom: upperTab,
                    iconTheme: const IconThemeData(color: Colors.white)),
              ),
              body: TabBarView(
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
    );
  }
}
