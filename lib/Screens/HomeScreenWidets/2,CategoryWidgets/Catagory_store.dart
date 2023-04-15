import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Providers/AppInfo.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/CategoryCard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/CategoryScreen.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:ghioon_buyer/Services/Database/SellerDatabase/sellerDatabase.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';

import '../../../Models/models.dart';

class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key});

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);
    final catagory = Provider.of<List<Category>>(context);
    var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(69.0),
      //   child: AppBar(
      //       centerTitle: true,
      //       title: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         // ignore: prefer_const_literals_to_create_immutables
      //         children: [
      //           Text(Language().categories[languageprov.LanguageIndex],
      //               style: TextStyle(
      //                   fontSize: 28.0,
      //                   color: appInformation.appColor,
      //                   fontWeight: FontWeight.w600)),
      //         ],
      //       ),
      //       // excludeHeaderSemantics: true,
      //       backgroundColor: Colors.white,
      //       // automaticallyImplyLeading: false,
      //       elevation: 0,
      //       iconTheme: const IconThemeData(color: Colors.white)),
      // ),
      body: Container(
        height: ScreenSize().ScreenHeight(context),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: catagory.length == 0
                    ? EmptyScreen(context, 'No Category.')
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            childAspectRatio: (2.5 / 3),
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: catagory.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StreamProvider<
                                          List<SellerInformation>>.value(
                                        initialData: [],
                                        value: SellerDatabaseService(
                                                businessType:
                                                    catagory[index].type)
                                            .sellers,
                                        child: CategoryScreen(
                                          category: catagory[index].name,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: CategoryCard(
                                    text: catagory[index].name,
                                    image: catagory[index].image));
                          },
                        ),
                      )

                // ListView.builder(
                //     shrinkWrap: true,
                //     // scrollDirection: Axis.horizontal,
                //     itemCount: catagory.length,
                //     physics: const BouncingScrollPhysics(
                //       parent: AlwaysScrollableScrollPhysics(),
                //     ),
                //     // physics: const NeverScrollableScrollPhysics()
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child:
                //       );
                //     },
                //   ),
                ),
          ],
        ),
      ),
    );
  }
}
