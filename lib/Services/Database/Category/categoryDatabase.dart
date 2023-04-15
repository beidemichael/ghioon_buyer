import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ghioon_buyer/Models/models.dart';

class CategoryDatabaseService {
  var userUid;
  CategoryDatabaseService({this.userUid});
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('Category');
  List<Categories> _businessListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Categories(
        type: (doc.data() as dynamic)['type'] ?? '',
          image: (doc.data() as dynamic)['image'] ?? '',
            name: (doc.data() as dynamic)['name'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  Stream<List<Categories>> get categories {
    return categoryCollection.snapshots().handleError((onError) {
      print(onError.toString());
    }).map(_businessListFromSnapshot);
  }
}
