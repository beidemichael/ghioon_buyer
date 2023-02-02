import 'package:flutter/cupertino.dart';

class Order_Provider with ChangeNotifier {
  final quantity = TextEditingController(text: "1");

  addquantity() {
    //Qty = Qty + 1;
    quantity.text = (int.parse(quantity.text) + 1).toString();
    notifyListeners();
  }

  minusquantity() {
    //  Qty > 0 ? Qty = Qty - 1 : Qty = 0;
    int.parse(quantity.text) > 1
        ? quantity.text = (int.parse(quantity.text) - 1).toString()
        : quantity.text = '1';
    notifyListeners();
  }
}
