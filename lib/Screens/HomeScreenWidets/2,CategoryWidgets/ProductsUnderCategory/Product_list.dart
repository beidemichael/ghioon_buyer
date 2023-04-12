import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/ProductsUnderCategory/GridListCard.dart';
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

class SellersUnderCategoryGrid extends StatelessWidget {
  const SellersUnderCategoryGrid({
    Key? key,
  }) : super(key: key);

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




            // child: GridView.builder(
            //   shrinkWrap: true,
            //   physics: const BouncingScrollPhysics(
            //       parent: AlwaysScrollableScrollPhysics()),
            //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 200,
            //     childAspectRatio: (2.5 / 3),
            //     crossAxisSpacing: 4.0,
            //     mainAxisSpacing: 8.0,
            //   ),
            //   itemCount: products.length,
            //   itemBuilder: (BuildContext ctx, index) {
            //     return GestureDetector(
            //       onTap: () async {
                   
            //         // if (sellers[index].online) {
            //         //   Navigator.push(
            //         //     context,
            //         //     MaterialPageRoute(
            //         //       builder: (context) =>
            //         //           StreamProvider<List<SellerInformation>>.value(
            //         //         initialData: [],
            //         //         value: SellerDatabaseService(
            //         //                 sellerId: sellers[index].userUid)
            //         //             .sellerprofile,
            //         //         child: StoreProfile(),
            //         //       ),
            //         //     ),
            //         //   );
            //         //   await SellerDatabaseService().addUserRead(
            //         //       userInfo[0].userName,
            //         //       userInfo[0].userUid,
            //         //       Timestamp.now(),
            //         //       sellers[index].userUid);
            //         // } else {
            //         //   snackBar(context, 'Store is closed', CustomColors().blue,
            //         //       Colors.white);
            //         // }
            //       },
            //       child: SellersUnderCategoryProductListCard(
            //           product: products[index]),
            //     );
            //   },
            // ),
          );
  }
}





class productWidget extends StatelessWidget {
  const productWidget({
    Key? key,
    required this.width,
    required this.product
  }) : super(key: key);

  final double width;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
      child: Container(
        height: width / 4.5,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListTile(
              title: Text(
                product.name,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: Dimensions.font23,
                    color: CustomColors().black,
                    fontWeight: FontWeight.w700),
              ),
              leading:  product.image.isNotEmpty
                            ? Container(
                              width: width/7,
                              
                              
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)
                                     ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: product.image[0],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.grey[300]!),
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                            )
                            : Center(
                                child: Icon(
                                  FontAwesomeIcons.store,
                                  size: 70,
                                  color: CustomColors().blue,
                                ),
                              ), //Image.asset('assets/images/head.png'),
              subtitle: Text(
              product.userUid,
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: CustomColors().grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Text("ETB 1800",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: CustomColors().black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
          ),
         
        ]),
      ),
    );
  }
}

