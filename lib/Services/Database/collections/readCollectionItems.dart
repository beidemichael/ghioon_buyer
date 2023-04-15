import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';

class ReadCollectionItemsDatabaseService {
  var collection;
  var userUid;
  ReadCollectionItemsDatabaseService({this.collection, this.userUid});
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  List<CollectionItems> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CollectionItems(
        productId: (doc.data() as dynamic)['productId'] ?? '',
        name: (doc.data() as dynamic)['name'] ?? '',
        description: (doc.data() as dynamic)['description'] ?? '',
        fixed: (doc.data() as dynamic)['fixed'] ?? '',
        price: (doc.data() as dynamic)['price'] ?? '',
        rangeFrom: (doc.data() as dynamic)['rangeFrom'] ?? '',
        rangeTo: (doc.data() as dynamic)['rangeTo'] ?? '',
        Product_Type: (doc.data() as dynamic)['Product_Type'] ?? '',
        Product_collection: (doc.data() as dynamic)['Product_collection'] ?? '',
        rating: (doc.data() as dynamic)['rating'] ?? '',
        video: (doc.data() as dynamic)['video'] ?? '',
        category: (doc.data() as dynamic)['category'] ?? '',
        image: (doc.data() as dynamic)['image'] ?? '',
        inStock: (doc.data() as dynamic)['isStock'] ?? '',
        quantity: (doc.data() as dynamic)['quantity'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<CollectionItems>> get readCollectionItems {
    return productCollection
        .where('category', isEqualTo: collection)
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_productListFromSnapshot);
  }
}
