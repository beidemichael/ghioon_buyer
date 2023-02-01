import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';

class ReadCategoryDatabaseService {
  var barcode;
  ReadCategoryDatabaseService({this.barcode});
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('Category');
  List<Category> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Category(
        type: (doc.data() as dynamic)['type'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Category>> get readCategory {
    return categoryCollection.snapshots().map(_productListFromSnapshot);
  }
}
