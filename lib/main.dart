import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/Order_Provider.dart';
import 'package:ghioon_buyer/Screens/GetStarted/Screens/0,Splash.dart';
import 'package:ghioon_buyer/Screens/home.dart';
import 'package:ghioon_buyer/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.apps;
//   runApp(MaterialApp(
//     // title: 'Flutter Demo',
//     home: MultiProvider(
//       providers: [
//         // ChangeNotifierProvider(
//         //   create: (context) => RangeData(),
//         // ),

//         StreamProvider<List<Product>>.value(
//           initialData: [],
//           value: ReadProductDatabaseService().readProduct,
//         ),

//         // StreamProvider<List<Collection>>.value(
//         //   initialData: [],
//         //   value: ReadCollectionDatabaseService(
//         //           userUid: FirebaseAuth.instance.currentUser!.uid)
//         //       .readCollection,
//         // ),
//         // StreamProvider<List<UserInformation>>.value(
//         //   initialData: [],
//         //   value: UserDatabaseService(
//         //           userUid: FirebaseAuth.instance.currentUser?.uid)
//         //       .userInfo,
//         // ),
//         // StreamProvider<List<Controller>>.value(
//         //   initialData: [],
//         //   value: ControllerDatabaseService().controller,
//         // ),
//       ],
//       child: const MyApp(),
//     ),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return HomeScreen();
//   }
// }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Scaffold(
// //         body: StreamProvider<UserAuth?>.value(
// //           value: AuthServices().user,
// //           initialData: null,
// //           child: const Wrapper(),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Models/models.dart';
import 'Providers/AppInfo.dart';
import 'Screens/SignIn/SignInLogic/wrapper.dart';
import 'Services/Database/Category/readCategory.dart';
import 'Services/Database/Product/readProduct.dart';
import 'Services/PhoneAuth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firebase.apps;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppInformation(),
          ),
          // ChangeNotifierProvider(
          //   create: (context) => RangeData(),
          // ),
          // ChangeNotifierProvider(
          //   create: (context) => EditRangeData(),
          // ),
          // ChangeNotifierProvider(
          //   create: (context) => EditProfileData(),
          // ),
          // ChangeNotifierProvider(
          //   create: (context) => MapProvider(),
          // ),
          // ChangeNotifierProvider(
          //   create: (context) => CollectionData(),
          // ),
          // ChangeNotifierProvider(
          //   create: (context) => FeedbackData(),
          // ),
          ChangeNotifierProvider(
            create: (context) => Order_Provider(),
          ),
          StreamProvider<List<Product>>.value(
            initialData: [],
            value: ReadProductDatabaseService().readProduct,
          ),
          StreamProvider<List<Category>>.value(
            initialData: [],
            value: ReadCategoryDatabaseService().readCategory,
          ),
          

          // StreamProvider<List<Collection>>.value(
          //   initialData: [],
          //   value: ReadCollectionDatabaseService(
          //           userUid: FirebaseAuth.instance.currentUser!.uid)
          //       .readCollection,
          // ),
          // StreamProvider<List<UserInformation>>.value(
          //   initialData: [],
          //   value: UserDatabaseService(
          //           userUid: FirebaseAuth.instance.currentUser?.uid)
          //       .userInfo,
          // ),
          // StreamProvider<List<Controller>>.value(
          //   initialData: [],
          //   value: ControllerDatabaseService().controller,
          // ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamProvider<UserAuth?>.value(
          value: PhoneAuthServices().user,
          initialData: null,
          child: Splash(),
        ),
      ),
    );
  }
}
