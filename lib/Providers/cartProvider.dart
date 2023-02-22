import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:ghioon_buyer/Models/models.dart';

import '../Services/Database/Orders/DatabaseOrders.dart';

class CartProvider with ChangeNotifier {
  var context;
  bool upLoading = false;
  List<CartItems> cartList = [];
  double total = 0.0;
  final promoCode = TextEditingController(); //(text: "1");
  bool cash = true;
  List foodName = [];
  List foodImage = [];
  List foodPrice = [];
  List foodQuantity = [];
  List sellerId = [];
  List itemsDelivered = [];
  var created;
  double longitude = 0.0;
  double latitude = 0.0;
  String information = '';

  String userName = '';
  String userPhone = '';
  String userUid = '';
  String userPic = '';

  addToCart(Product product, int quantity, String sellerId) {
    cartList.add(
        CartItems(product: product, quantity: quantity, sellerId: sellerId));
    notifyListeners();
  }

  onDismiss(Product product) {
    cartList.removeWhere((p) => p.product.productId == product.productId);
    totalPrice();
    notifyListeners();
  }

  addQuantity(index) {
    cartList[index].quantity = cartList[index].quantity + 1;
    notifyListeners();
  }

  minusQuantity(int index) {
    cartList[index].quantity > 1
        ? cartList[index].quantity = cartList[index].quantity - 1
        : cartList[index].quantity = 1;
    notifyListeners();
  }

  totalPrice() {
    total = 0;
    for (var cartitem in cartList) {
      total = total + (cartitem.product.price[0] * cartitem.quantity);
    }
    notifyListeners();
  }

  uploadToDatabase() async {
    upLoading = true;
    notifyListeners();
    foodName = [];
    foodImage = [];
    foodPrice = [];
    foodQuantity = [];
    sellerId = [];
    itemsDelivered = [];
    for (int i = 0; i < cartList.length; i++) {
      foodName.add(cartList[i].product.name);
      foodPrice.add(cartList[i].product.price[0]);
      foodQuantity.add(cartList[i].quantity);
      foodImage.add(cartList[i].product.image[0]);
      sellerId.add(cartList[i].product.userUid);
      itemsDelivered.add(false);
    }
    await DatabaseOrders().addOrderData(
        foodName,
        foodPrice,
        foodQuantity,
        foodImage,
        itemsDelivered,
        total,
        total * 0.05,
        15,
        0,
        0,
        promoCode.text,
        false,
        false,
        false,
        userName,
        userPhone,
        userUid,
        userPic,
        longitude,
        latitude,
        information,
        created,
        generateRandomString(5),
        cash,
        context);
    cartList = [];
    upLoading = false;
    notifyListeners();
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
