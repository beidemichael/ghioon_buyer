import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Providers/Order_Provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../Shared/customColors.dart';

class Quantity extends StatefulWidget {
  var quantity;
  Quantity({super.key, required this.quantity});

  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      // const Text(
      //   "Quantity",
      //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      // ),
      // const SizedBox(
      //   width: 15,
      // ),
      Row(
        children: [
          GestureDetector(
              onTap: () {
                Provider.of<Order_Provider>(context, listen: false)
                    .minusquantity();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: CustomColors().blue),
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child:
                      Icon(FontAwesomeIcons.minus, color: CustomColors().blue),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: CustomColors().blue),
                color: CustomColors().white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                  child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: widget.quantity,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: CustomColors().blue))),
            ),
          ),
          GestureDetector(
              onTap: () {
                Provider.of<Order_Provider>(context, listen: false)
                    .addquantity();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: CustomColors().blue),
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child:
                      Icon(FontAwesomeIcons.plus, color: CustomColors().blue),
                ),
              ))
        ],
      ),
    ]);
  }
}
