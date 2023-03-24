import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';

class SellerDatabaseService {
  var sellerId;
  var businessType;
  SellerDatabaseService({this.businessType, this.sellerId});
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
        viewCountTime: (doc.data() as dynamic)['viewCountTime'] ?? [],
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

  Stream<List<SellerInformation>> get sellerprofile {
    return sellersCollection
        .where('userUid', isEqualTo: sellerId)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }

  Future<bool> getOnline(String sellerId) async {
    DocumentReference documentReference = sellersCollection.doc(sellerId);
    bool online = false;
    await documentReference.get().then((snapshot) {
      online = (snapshot.data() as dynamic)['online'] ?? false;
      // online = snapshot.data['specie'].toString();
    });
    return online;
  }

  Future<String> getSellerPhone(String sellerId) async {
    DocumentReference documentReference = sellersCollection.doc(sellerId);
    String phone = "0";
    await documentReference.get().then((snapshot) {
      phone = (snapshot.data() as dynamic)['phoneNumber'] ?? false;
      // online = snapshot.data['specie'].toString();
    });
    return phone;
  }

  Future addUserRead(
      String userName, String userUid, var time, String documentId) async {
    return await sellersCollection.doc(documentId).update({
      'viewCountUserName': FieldValue.arrayUnion([userName]),
      'viewCountUserUid': FieldValue.arrayUnion([userUid]),
      'viewCountTime': FieldValue.arrayUnion([time]),
    });
  }
}
