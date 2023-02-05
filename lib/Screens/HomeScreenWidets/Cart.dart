import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/AppInfo.dart';
import 'package:ghioon_buyer/Providers/cartProvider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/CartWidgets/cartListItem.dart';
import 'package:ghioon_buyer/Screens/components/BlueButton.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:ghioon_buyer/Screens/components/textFormField.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});


  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final appInformation = Provider.of<AppInformation>(context);
   return Scaffold(
    appBar: AppBar(
      backgroundColor: CustomColors().white,
      elevation: 0,
      title: Center(
        child: Text("Cart",  style: TextStyle(
                        fontSize: 28.0,
                        color: appInformation.appColor,
                        fontWeight: FontWeight.w600)),
      ),
      actions: [
      
       Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: CustomColors().blue,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  cart.cartList.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
     body: ListView(
       children: [
        cart.cartList.isNotEmpty? Container(
          height: ScreenSize().ScreenHeight(context)*0.55,
           child: ListView.builder(
              itemCount: cart.cartList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(cart.cartList[index].product.productId),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                   cart.onDismiss(cart.cartList[index].product);
                  },
                  background: Container(
                    color: CustomColors().blue,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                           Icons.delete,
                          color: CustomColors().white,
                        ),
                      ),
                    ),
                  ),
                  child: CartListItem( index: index,),
                );
              },
            ),
         ):
         Container( height: ScreenSize().ScreenHeight(context)*0.55,child: EmptyScreen(context,"No Product in Cart"))
         ,
         Expanded(
           child: Container(
            decoration: BoxDecoration( color: CustomColors().white, borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),
             boxShadow: [
            BoxShadow(
              color: CustomColors().grey,
              offset: Offset(3.0, 3.0),
              blurRadius: 5.0,
            ),
          ],
            ),
            child: Column(
              children: [Padding(
                padding: const EdgeInsets.fromLTRB(15.0,15,15,8),
                child: Container(
                  height: ScreenSize().ScreenHeight(context)*0.095,
                  //decoration:BoxDecoration(color: CustomColors().white),
                   decoration: BoxDecoration(
                    color: CustomColors().white,
                    borderRadius: const BorderRadius.all(
                     Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 2,
                        offset: const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                 child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [ 
                    Expanded(child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                      child: TextFormFieldWithOutLabel("Promo Code",cart.promoCode,  TextInputType.text ),
                    )),
                  Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(height: ScreenSize().ScreenHeight(context)*0.06, width: ScreenSize().ScreenWidth(context)*0.3, decoration: BoxDecoration(
                    color: CustomColors().blue,
                    borderRadius: const BorderRadius.all(
                     Radius.circular(10)
                    ),
                   
                  ),child: Center(child: Text('Apply', style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: ScreenSize().ScreenWidth(context)*0.05,
                        color: CustomColors().white,
                        fontWeight: FontWeight.w700))),),
                 ),  ],)
                ),
              ),Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total', style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 30,
                        color: CustomColors().blue,
                        fontWeight: FontWeight.w700)),
                  Text("ETB " + cart.total.toString(), style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        color: CustomColors().black,
                        fontWeight: FontWeight.w700))
                  ]),
                ),
              ),Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,8,20),
                      child: BlueButton(text: "Proceed To Checkout",),
                    ),
                  ],
                ),
              ),],

            ),
           ),
         )
       ],
     ),
   );
  }
}





// CartListItem(
//         productName: "Product Name",
//         price: 19.99,
//         productImageUrl: 'https://techdeluxe.eu/wp-content/uploads/2022/12/black-1.jpeg',// "https://example.com/product.jpg",
//         quantity: 1,
//         onMinusButtonPressed: () {
//           // decrease quantity
//         },
//         onPlusButtonPressed: () {
//           // increase quantity
//         },
//       )