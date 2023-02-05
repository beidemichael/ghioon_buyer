import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/Order_Provider.dart';
import 'package:ghioon_buyer/Providers/cartProvider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductDetailWidgets.dart/images.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductDetailWidgets.dart/titleAndDescription.dart';
import 'package:ghioon_buyer/Screens/components/SnackBar.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../Shared/constants.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
     final cart = Provider.of<CartProvider>(context);
      final order = Provider.of<Order_Provider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: ScreenSize().ScreenHeight(context),
              color: CustomColors().blue,
              child: Column(
                children: [
                  Container(
                    height: ScreenSize().ScreenHeight(context) * 0.9,
                    decoration: BoxDecoration(
                      color: CustomColors().white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        ImagesList(product: widget.product),
                        TitleAndDescription(product: widget.product),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Inter',
                                    color: CustomColors().white,
                                    fontWeight: FontWeight.w700)),
                            Text('ETB ' + widget.product.price[0].toString(),
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Inter',
                                    color: CustomColors().white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          width: ScreenSize().ScreenWidth(context) * 0.45,
                          height: ScreenSize().ScreenWidth(context) * 0.15,
                          decoration: BoxDecoration(
                            color: CustomColors().white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: (){
                              if(cart.cartList.contains(widget.product)){
                               snackBar(context,"Product already in cart",CustomColors().red, CustomColors().white);
                              }
                              else{
                                cart.addToCart(widget.product, int.parse(order.quantity.text));
                                cart.totalPrice();
                                snackBar(context,"Product added to Cart",CustomColors().white, CustomColors().blue);
                                print("product added");
                                if (cart.cartList.isNotEmpty){
                                      print(cart.cartList[0].product.name);
                                }
                                else{
                                  print("no cart");
                                }
                              }

                              
                             
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(FontAwesomeIcons.cartShopping),
                                Text("ADD TO CART",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Inter',
                                        color: CustomColors().black,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
