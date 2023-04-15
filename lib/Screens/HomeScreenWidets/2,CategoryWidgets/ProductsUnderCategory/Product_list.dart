import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/ProductsUnderCategory/Product_Catagory_card.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/SellersUnderCategory/StoreProfile/store_profile.dart';
//import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Screens/components/SnackBar.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:ghioon_buyer/Services/Database/SellerDatabase/sellerDatabase.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Services/Database/Product/readProduct.dart';
import '../../3,DashboardWidgets/ProductForGrid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsUnderCategoryGrid extends StatelessWidget {
  
 const ProductsUnderCategoryGrid({Key? key, required this.category,})
      : super(key: key);

  final String category;
  
  @override
  Widget build(BuildContext context) {
    bool clicked = false;
    final products = Provider.of<List<Product>>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    return userInfo == null
        ? Loading()
        : Padding(
            padding: const EdgeInsets.all(8.0),



 child: products.isNotEmpty
                ? Container(
                    height: ScreenSize().ScreenHeight(context) * 0.55,
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        
                        return GestureDetector(
                          onTap: () async{
                            if (clicked == false) {
                              clicked = true;

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
                                clicked = false;
                              } else {
                                snackBar(context, 'Product not available.',
                                    CustomColors().blue, Colors.white);
                                clicked = false;
                              }
                            }
                          },
                          child: productWidget(
                            width: ScreenSize().ScreenWidth(context),
                            product: products[index],
                            category:category,
                           
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    height: ScreenSize().ScreenHeight(context),
                    child: EmptyScreen(context,
                       "no Products"),
                  ),




          );
  }
}


