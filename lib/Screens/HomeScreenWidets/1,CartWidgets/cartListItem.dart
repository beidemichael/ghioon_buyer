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
              //image
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: cart.cartList[index].product.image[0] != ''
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: cart.cartList[index].product.image[0],
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.newspaper_rounded,
                        size: 10,
                        color: Colors.grey[400],
                      ),
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
                    Text(
                      cart.cartList[index].product.name,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: CustomColors().blue,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'ETB ' + cart.cartList[index].product.price[0].toString(),
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: CustomColors().black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.arrow_left, color: Colors.red.withOpacity(0.5)),
                    Text(
                      "Swip Left to Remove",
                      style: TextStyle(color: Colors.red.withOpacity(0.5)),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      cart.minusQuantity(index);
                      cart.totalPrice();
                    } // onMinusButtonPressed,
                    ),
                Text(cart.cartList[index].quantity.toString()),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      cart.addQuantity(index);
                      cart.totalPrice();
                    } //onPlusButtonPressed,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
