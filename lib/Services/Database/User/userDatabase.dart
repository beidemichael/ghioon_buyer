import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';

class UserDatabaseService {
  var userUid;
  UserDatabaseService({this.userUid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  List<UserInformation> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInformation(
        userName: (doc.data() as dynamic)['name'] ?? '',
        phoneNumber: (doc.data() as dynamic)['phoneNumber'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        documentId: doc.reference.id,
        image: (doc.data() as dynamic)['image'] ?? '',
        gender: (doc.data() as dynamic)['gender'] ?? '',
        birthday: (doc.data() as dynamic)['birthday'] ?? DateTime.now(),
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<UserInformation>> get userInfo {
    print(userUid);

    return userCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }

  Future registerInformation(
    String name,
    String email,
    var phoneNumber,
    var userUid,
    String gender,
    var birthday,
  ) async {
    userCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (docs.docs.isEmpty) {
        return await userCollection
            .doc(userUid)
            .set({
              'created': Timestamp.now(),
              'name': name,
              'email': email,
              'userUid': userUid,
              'phoneNumber': phoneNumber,
              'image': '',
              'gender': gender,
              'birthday':birthday
            })
            .then((value) => print("Registration Info Added"))
            .catchError((error) => print("Failed to Register: $error"));
      }
    });
  }

  Future updateUserInformation(
    String name,
    String email,
    var phoneNumber,
    var userUid,
    String image,
    String gender,
    var birthday,
  ) async {
    userCollection.doc(userUid).update({
      'created': Timestamp.now(),
      'name': name,
      'email': email,
      'userUid': userUid,
      'phoneNumber': phoneNumber,
      'image': image,
      'gender': gender,
      'birthday':birthday
    });
  }
}
