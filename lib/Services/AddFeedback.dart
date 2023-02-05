import 'package:cloud_firestore/cloud_firestore.dart';

class addFeedbackDatabase {
  var userUid;
  addFeedbackDatabase({this.userUid});
  final CollectionReference feedbackcollection =
      FirebaseFirestore.instance.collection('Feedbacks');

  Future addFeedback(
    String description,
    var userUid,
  ) async {
    DocumentReference ref = feedbackcollection.doc();
    return await feedbackcollection
        .doc(ref.id)
        .set({
          'created': Timestamp.now(),
          'feedbackId': ref.id,
          'description': description,
          'userUid': userUid,
          'from': 'User'
        })
        .then((value) => print("Feedback sent"))
        .catchError((error) => print("Failed to send Feedback: $error"));
  }
}
