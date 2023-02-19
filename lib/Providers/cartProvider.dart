import 'package:flutter/cupertino.dart';
import 'package:ghioon_buyer/Models/models.dart';

import '../Services/Database/Orders/DatabaseOrders.dart';

class CartProvider with ChangeNotifier{

bool upLoading = false;
   List<CartItems> cartList = [];
double total = 0.0;
final promoCode = TextEditingController(); //(text: "1");
  
  addToCart(Product product, int quantity,String sellerId){
    cartList.add(CartItems(product: product, quantity: quantity,sellerId: sellerId));
    notifyListeners();
  }
  onDismiss(Product product) {
    cartList.removeWhere((p) => p.product.productId == product.productId);
    totalPrice();
    notifyListeners();
  }
  addQuantity(index){
cartList[index].quantity = cartList[index].quantity + 1;
    notifyListeners(); 
  }
  minusQuantity(int index){

    cartList[index].quantity>1?cartList[index].quantity = cartList[index].quantity - 1: cartList[index].quantity = 1 ;
    notifyListeners(); 

  }
  totalPrice(){
    total = 0;
    for (var cartitem in cartList){
      total= total+(cartitem.product.price[0]*cartitem.quantity);

    }
    notifyListeners();
  }
  uploadToDatabase() async{
    upLoading = true;
    notifyListeners();
    // await DatabaseOrders().addOrderData(foodName, foodPrice, foodQuantity, foodImage, subTotal, serviceCharge, deliveryFee, tip, distance, promoCode, isTaken, isDelivered, isCancelled, userName, userPhone, userUid, userPic, longitude, latitude, information, created, orderNumber, cash, context)
    upLoading = false;
    notifyListeners();
  }

}