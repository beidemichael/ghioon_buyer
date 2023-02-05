import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/cartProvider.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';
class CartListItem extends StatelessWidget {
  // final Product product;
  // int quantity;
  int index;

  CartListItem({
    // required  this.product,

    // required this.quantity,
    required this.index,
    
  });

  @override
  Widget build(BuildContext context) {
     final cart = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: CustomColors().white,
           borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              color: CustomColors().grey,
              offset: Offset(3.0, 3.0),
              blurRadius: 5.0,
            ),
          ],

        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                // image: DecorationImage(
                //   image: NetworkImage(product.image.toString()),
                //   fit: BoxFit.contain,
                // ),
              ),
              child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: cart.cartList[index].product.image[0].toString(),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.grey[300]!),
                                    value: downloadProgress.progress),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
            ),
            SizedBox(width: 8),
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( cart.cartList[index].product.name, style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            color: CustomColors().blue,
                            fontWeight: FontWeight.w700),),
                    Text('ETB ' +  cart.cartList[index].product.price[0].toString(),
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: CustomColors().black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),),
                         
                  ],
                ),
                SizedBox(height: 10,),
                 Row(
                   children: [
                    Icon(Icons.arrow_left, color:Colors.red.withOpacity(0.5)) ,
                     Text("Swip Left to Remove", style: TextStyle(color: Colors.red.withOpacity(0.5)),),
                   ],
                 )
              ],
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed:(){
                    cart.minusQuantity(index);
                    cart.totalPrice();
                  
                  }// onMinusButtonPressed,
                ),
                Text(cart.cartList[index].quantity.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    cart.addQuantity(index);
                    cart.totalPrice();
                  }//onPlusButtonPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
