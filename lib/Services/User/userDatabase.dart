import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/models.dart';

class UserDatabaseService {
  var userUid;
  UserDatabaseService({this.userUid});
  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('Users');
  List<UserInformation> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInformation(
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
  Stream<List<UserInformation>> get userInfo {
    print(userUid);

    return sellersCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }
}
