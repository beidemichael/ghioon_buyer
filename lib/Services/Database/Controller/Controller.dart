import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Models/models.dart';

class ControllerDatabaseService {
  final CollectionReference controllerCollection =
      FirebaseFirestore.instance.collection('Controller');
  List<VersionController> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return VersionController(
        sellerVersion: (doc.data() as dynamic)['BuyerAppVersion'] ?? 1,
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<VersionController>> get controller {
    return controllerCollection.snapshots().map(_productListFromSnapshot);
  }
}
