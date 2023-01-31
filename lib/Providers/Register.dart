// // ignore_for_file: prefer_typing_uninitialized_variables, file_names

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';

// import '../Services/Database/Database.dart';



// class Register extends ChangeNotifier {
//   String screen = 'BecomeACarrier';
//   String carrierName = '';
//   var carrierPhoto;
//   String carrierPhotoString = '';
//   bool upLoadLoding = false;

//   void changeScreen(String screenFunction) {
//     screen = screenFunction;
//     notifyListeners();
//   }

//   void addPhoto(var photo, String type) {
//     if (type == 'carrier') {
//       carrierPhoto = photo;
//     } else {}

//     notifyListeners();
//   }

//   void becomeACarrierSetVariables(
//     String driverNameFunction,
//   ) {
//     carrierName = driverNameFunction;
//     notifyListeners();
//   }

//   Future<void> uploadToDatabase() async {
//     upLoadLoding = true;
//     notifyListeners();
//     if (carrierPhoto != null) {
//       FirebaseStorage storage = FirebaseStorage.instance;
//       Reference ref = storage
//           .ref()
//           .child("Carrier/CarrierPhoto/CarrierPhoto${DateTime.now()}");
//       UploadTask uploadTask = ref.putFile(carrierPhoto!);

//       await uploadTask.then((res) async {
//         final String downloadUrl = await res.ref.getDownloadURL();

//         carrierPhotoString = downloadUrl;
//       });
//     }

//     final user = FirebaseAuth.instance.currentUser;
//     final phoneNumber = user!.phoneNumber;
//     final userUid = user.uid;
//     DatabaseService().registerInformation(
//       carrierName,
//       carrierPhotoString,
//       phoneNumber,
//       userUid,
//     );
//     upLoadLoding = false;
//     screen = 'Pending';
//     notifyListeners();
//   }
// }
