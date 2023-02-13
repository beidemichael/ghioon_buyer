import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';

class ReadProductDatabaseService {
  var barcode;
  var userUid;
  var productName;
  ReadProductDatabaseService({this.barcode, this.userUid, this.productName});
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
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
        barcode: (doc.data() as dynamic)['barcode'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Product>> get readProduct {
    return productCollection
        //.where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_productListFromSnapshot);
  }

  Stream<List<Product>> get readSellerProduct {
    return productCollection
        .where("name", isGreaterThanOrEqualTo: productName)
        .where("name", isLessThan: productName + "\uf8ff")
        .snapshots()
        .map(_productListFromSnapshot);
  }

  Stream<List<Product>> get readSearchProduct {
    return productCollection
        .where("name", isEqualTo: productName)
        .snapshots()
        .map(_productListFromSnapshot);
  }

  List<ProductBar> _productBarListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ProductBar(
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
        barcode: (doc.data() as dynamic)['barcode'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  Stream<List<ProductBar>> get readProductBarCode {
    return productCollection
        //.where('userUid', isEqualTo: userUid)
        .where('barcode', isEqualTo: barcode)
        .snapshots()
        .map(_productBarListFromSnapshot);
  }
}
