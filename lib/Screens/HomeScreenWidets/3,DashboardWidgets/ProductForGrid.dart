import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
//import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/ProductGridListCard.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Screens/components/SnackBar.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Services/Database/Product/readProduct.dart';
import 'package:ghioon_buyer/Services/Database/SellerDatabase/sellerDatabase.dart';
import 'package:provider/provider.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

class ProductForGrid extends StatelessWidget {
  const ProductForGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    print("Products");
    final products = Provider.of<List<Product>>(context);
    print(products);
    return userInfo == null
        ? Loading()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
              child: products.isNotEmpty
                  ? GridView.builder(
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
                      itemCount: products.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () async {
                            if (await SellerDatabaseService()
                                    .getOnline(products[index].userUid) ==
                                true) {
                              var phone = await SellerDatabaseService()
                                  .getSellerPhone(products[index].userUid);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          product: products[index],
                                          phone: phone,
                                        )),
                              );
                              await ReadProductDatabaseService().addUserRead(
                                  userInfo[0].userName,
                                  userInfo[0].userUid,
                                  Timestamp.now(),
                                  products[index].documentId);
                            } else {
                              snackBar(context, 'Product not available.',
                                  CustomColors().blue, Colors.white);
                            }
                          },
                          child: ProductListCard(product: products[index]),
                        );
                      },
                    )
                  : EmptyScreen(context, "No Products in Store"),
            ),
          );
  }
}
