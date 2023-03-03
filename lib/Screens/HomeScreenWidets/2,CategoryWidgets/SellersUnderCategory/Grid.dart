import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/SellersUnderCategory/GridListCard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/SellersUnderCategory/StoreProfile/store_profile.dart';
//import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/ProductGridListCard.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Screens/components/SnackBar.dart';
import 'package:ghioon_buyer/Services/Database/SellerDatabase/sellerDatabase.dart';
import 'package:provider/provider.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Services/Database/Product/readProduct.dart';
import '../../3,DashboardWidgets/ProductForGrid.dart';

class SellersUnderCategoryGrid extends StatelessWidget {
  const SellersUnderCategoryGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sellers = Provider.of<List<SellerInformation>>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    return userInfo == null
        ? Loading()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: (2.5 / 3),
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: sellers.length,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                  onTap: () async {
                    print(sellers[index].userUid);
                    if (sellers[index].online) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StreamProvider<List<SellerInformation>>.value(
                            initialData: [],
                            value: SellerDatabaseService(
                                    sellerId: sellers[index].userUid)
                                .sellerprofile,
                            child: StoreProfile(),
                          ),
                        ),
                      );
                      await SellerDatabaseService().addUserRead(
                          userInfo[0].userName,
                          userInfo[0].userUid,
                          Timestamp.now(),
                          sellers[index].userUid);
                    } else {
                      snackBar(context, 'Store is closed', CustomColors().blue,
                          Colors.white);
                    }
                  },
                  child: SellersUnderCategoryProductListCard(
                      seller: sellers[index]),
                );
              },
            ),
          );
  }
}
