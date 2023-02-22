import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Models/models.dart';
import '../../../Screens/HomeScreenWidets/5,Profile/ProfileWidgets/SnackBar.dart';

class DatabaseOrders {
  String? userUid;
  DatabaseOrders({this.userUid});

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');

 

  Future addOrderData(
      List foodName,
      List foodPrice,
      List foodQuantity,
      List foodImage,
      List itemsDelivered,

      double subTotal,
      double serviceCharge,
      int deliveryFee,
      double tip,
      double distance,
      String promoCode,

      bool isTaken,
      bool isDelivered,
      bool isCancelled,

      String userName,
      String userPhone,
      String userUid,
      String userPic,

     
      double longitude,
      double latitude,
      String information,

      DateTime created,
      String orderNumber,

      bool cash,
      
      
      BuildContext context
      // String loungeMessagingToken,
      // String userMessagingToken,
      // String referralCode,
      ) async {
    return await orderCollection.add({
      'food': foodName,
      'price': foodPrice,
      'quantity': foodQuantity,
      'images': foodImage,
      'itemsDelivered':itemsDelivered,
      'subTotal': subTotal,
      'created': created,
      'isTaken': isTaken,
      'isCancelled': isCancelled,
      'isDelivered': isDelivered,
      'userName': userName,
      'userPhone': userPhone,
      'cash': cash,
      // 'userSex':userSex,
      'userUid': userUid,
      'userPic': userPic,
      'orderCode': orderNumber,
      'Longitude': longitude,
      'Latitude': latitude,
      'information': information,
      'carrierName': '',
      'carrierphone': '',
      'carrierUserUid': '',
      'carrierUserPic': '',
      'serviceCharge': serviceCharge,
      'deliveryFee': deliveryFee,
      'tip': tip,
      'distance': distance,
      'isPaid': false,
      'isBeingPrepared': false,
      'preparing': false,
      'eatThere': false,
      'carrierLatitude': 0.0,
      'carrierLongitude': 0.0,
      // 'loungeMessagingToken': loungeMessagingToken,
      // 'userMessagingToken': userMessagingToken,
      'promoCode': promoCode
    }).then((result) {
      snackBar(context, 'Order is Placed.', Colors.green, Colors.white);
      // orderConfirmation(context)
      print("Success!");
    });
  }

  List<Orders> _ordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Orders(
        foodName: (doc.data() as dynamic)['food'] ?? '',
        foodQuantity: (doc.data() as dynamic)['quantity'] ?? '',
        foodPrice: (doc.data() as dynamic)['price'] ?? '',
        deliveryFee: (doc.data() as dynamic)['deliveryFee'].toDouble() ?? 0.0,
        serviceCharge:
            (doc.data() as dynamic)['serviceCharge'].toDouble() ?? 0.0,
        tip: (doc.data() as dynamic)['tip'].toDouble() ?? 0,
        subTotal: (doc.data() as dynamic)['subTotal'].toDouble() ?? '',
        created: (doc.data() as dynamic)['created'] ?? Timestamp.now(),
        isTaken: (doc.data() as dynamic)['isTaken'] ?? false,
        orderNumber: (doc.data() as dynamic)['orderCode'] ?? '',
        userName: (doc.data() as dynamic)['userName'] ?? '',
        userPhone: (doc.data() as dynamic)['userPhone'] ?? '',
        documentId: doc.reference.id,
        latitude: (doc.data() as dynamic)['Latitude'].toDouble() ?? 0.0,
        longitude: (doc.data() as dynamic)['Longitude'].toDouble() ?? 0.0,
        carrierLatitude:
            (doc.data() as dynamic)['carrierLatitude'].toDouble() ?? 0.0,
        carrierLongitude:
            (doc.data() as dynamic)['carrierLongitude'].toDouble() ?? 0.0,
        carrierPhone: (doc.data() as dynamic)['carrierphone'] ?? '',
        carrierName: (doc.data() as dynamic)['carrierName'] ?? '',
        carrierImage: (doc.data() as dynamic)['carrierUserPic'] ?? '',
        isBeingPrepared: (doc.data() as dynamic)['isBeingPrepared'] ?? false,
        loungeOrderNumber: (doc.data() as dynamic)['loungeOrderNumber'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        userPic: (doc.data() as dynamic)['userPic'] ?? '',
        distance: (doc.data() as dynamic)['distance'].toDouble() ?? 0,
        foodImage: (doc.data() as dynamic)['images'] ?? [],
        information: (doc.data() as dynamic)['information'] ?? '',
        isCancelled: (doc.data() as dynamic)['isCancelled'] ?? false,
        isDelivered: (doc.data() as dynamic)['isDelivered'] ?? false,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Orders>> get orders {
    return orderCollection
        .where('isDelivered', isEqualTo: false)
        .where('userUid', isEqualTo: userUid)
        .orderBy('created', descending: true)
        .snapshots()
        .handleError((onError) {
      print(onError.toString());
    }).map(_ordersListFromSnapshot);
  }
}
