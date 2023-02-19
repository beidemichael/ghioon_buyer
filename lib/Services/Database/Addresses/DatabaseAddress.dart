import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Models/models.dart';


class DatabaseAddress {
  String? userUid;
  DatabaseAddress({this.userUid});
  final CollectionReference addressCollection =
      FirebaseFirestore.instance.collection('Address');

  List<Addresses> _adressListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Addresses(
        longitude: (doc.data() as dynamic)['Longitude'] ?? '',
        latitude: (doc.data() as dynamic)['Latitude'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        name: (doc.data() as dynamic)['name'] ?? '',
        information: (doc.data() as dynamic)['information'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Addresses>> get address {
    return addressCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_adressListFromSnapshot);
  }

  Future removeAdress(id) async {
    return await  addressCollection.doc(id).delete();
  }

  Future addAdress(
    double latitude,
    double longitude,
    String userUid,
    String name,
    String information,
  ) async {
    return await addressCollection.add({
      'created': Timestamp.now(),
      'Latitude': latitude,
      'Longitude': longitude,
      'userUid': userUid,
      'name': name,
      'information': information,
    });
  }
}
