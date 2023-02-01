import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';

class SellerDatabaseService {
  var businessType;
  SellerDatabaseService({this.businessType});
  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('Sellers');
  List<SellerInformation> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SellerInformation(
        GhioonId: (doc.data() as dynamic)['GhioonId'] ?? '',
        userName: (doc.data() as dynamic)['sellerName'] ?? '',
        phoneNumber: (doc.data() as dynamic)['phoneNumber'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        approved: (doc.data() as dynamic)['approved'] ?? '',
        businessCategory: (doc.data() as dynamic)['businessType'] ?? '',
        businessName: (doc.data() as dynamic)['businessName'] ?? '',
        businessNo: (doc.data() as dynamic)['businessNo'] ?? '',
        address: (doc.data() as dynamic)['address'] ?? '',
        views: (doc.data() as dynamic)['views'] ?? '',
        rating: (doc.data() as dynamic)['rating'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        documentId: doc.reference.id,
        online: (doc.data() as dynamic)['online'] ?? '',
        collections: (doc.data() as dynamic)['collections'] ?? '',
        collection_description:
            (doc.data() as dynamic)['collection_description'] ?? '',
        collection_images: (doc.data() as dynamic)['collection_images'] ?? '',
        image: (doc.data() as dynamic)['image'] ?? '',
        profileImages: (doc.data() as dynamic)['profileImages'] ?? [],
        profileVideo: (doc.data() as dynamic)['profileVideo'] ?? '',
        notification: (doc.data() as dynamic)['notification'] ?? false,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<SellerInformation>> get sellers {
    return sellersCollection
        .where('businessType', isEqualTo: businessType)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }
}
