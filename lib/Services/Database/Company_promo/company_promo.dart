import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';

class ReadCompanyPromoService {
  
  ReadCompanyPromoService();
  
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('Compnay');
  List<CompanyPromo> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CompanyPromo(
        image: (doc.data() as dynamic)['image'] ?? '',
        id:  (doc.data() as dynamic)['id'] ?? '',
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<CompanyPromo>> get readPromo {
    return categoryCollection.snapshots().map(_productListFromSnapshot);
  }
}
