import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Models/models.dart';
import '../../../Screens/HomeScreenWidets/5,Profile/ProfileWidgets/SnackBar.dart';

class DatabasePromotion {
  String? userUid;
  DatabasePromotion({this.userUid});

  final CollectionReference promotionCollection =
      FirebaseFirestore.instance.collection('Marketing');

  List<Promotion> _ordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Promotion(
        image: (doc.data() as dynamic)['image'] ?? '',
        video: (doc.data() as dynamic)['video'] ?? '',
        isImage: (doc.data() as dynamic)['isImage'] ?? '',
        sellerUid: (doc.data() as dynamic)['sellerUid'] ?? '',
        screenRealestate: (doc.data() as dynamic)['screenRealestate'] ?? '',
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Promotion>> get promotions {
    return promotionCollection
        .where('approved', isEqualTo: true)
        .orderBy('created', descending: true)
        .snapshots()
        .handleError((onError) {
      print(onError.toString());
    }).map(_ordersListFromSnapshot);
  }
}
