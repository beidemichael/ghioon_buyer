import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_buyer/Services/AddFeedback.dart';

import 'package:provider/provider.dart';

class FeedbackData with ChangeNotifier {
  bool isLoading = false;
  final feedbackDescription = TextEditingController();
  bool feedbackDescriptionFilled = true;

  switchfeedbackDescriptionFilled(bool feedbackDescriptionFilledInput) {
    feedbackDescriptionFilled = feedbackDescriptionFilledInput;
    notifyListeners();
  }

  checkFeedbackDescription(BuildContext context) {
    if (feedbackDescription.value.text.isNotEmpty) {
      switchfeedbackDescriptionFilled(true);
    } else {
      switchfeedbackDescriptionFilled(false);
    }
  }

  uploadToDatabase(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final userUid = user!.uid;

    await addFeedbackDatabase().addFeedback(feedbackDescription.text, userUid);
  }

  sendFeedback(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    uploadToDatabase(context);
    print('done');
    feedbackDescription.clear();

    Navigator.pop(context);
  }
}
