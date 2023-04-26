import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/FeedbackProvider.dart';
import 'package:ghioon_buyer/Providers/Order_Provider.dart';
import 'package:ghioon_buyer/Providers/RangeProvider.dart';
import 'package:ghioon_buyer/Providers/cartProvider.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Providers/search.dart';
import 'package:ghioon_buyer/Screens/GetStarted/Screens/0,Splash.dart';
import 'package:ghioon_buyer/Screens/home.dart';
import 'package:ghioon_buyer/Services/Database/Category/categoryDatabase.dart';
import 'package:ghioon_buyer/Services/Database/Company_promo/company_promo.dart';
import 'package:ghioon_buyer/Services/Database/Promotion/DatabasePromotion.dart';
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
import 'Screens/components/Loading.dart';
import 'Screens/update/forced_update.dart';
import 'Screens/update/optional_update.dart';
import 'Services/Database/Addresses/DatabaseAddress.dart';
import 'Services/Database/Category/readCategory.dart';
import 'Services/Database/Controller/Controller.dart';
import 'Services/Database/Product/readProduct.dart';
import 'Services/Database/User/userDatabase.dart';
import 'Services/PhoneAuth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firebase.apps;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppInformation(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => Order_Provider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FeedbackData(),
          ),
          StreamProvider<List<UserInformation>>(
            create: (_) {
              final userUid = FirebaseAuth.instance.currentUser?.uid;
              return UserDatabaseService(userUid: userUid).userInfo;
            },
            initialData: [],
          ),
          StreamProvider<List<Addresses>>(
            create: (_) {
              final userUid = FirebaseAuth.instance.currentUser?.uid;
              return DatabaseAddress(userUid: userUid).address;
            },
            initialData: [],
          ),
          // StreamProvider<List<Product>>.value(
          //   initialData: [],
          //   value: ReadProductDatabaseService().readProduct,
          // ),

          StreamProvider<List<Product>>(
            create: (_) {
              return ReadProductDatabaseService().readProduct;
            },
            initialData: [],
          ),
          StreamProvider<List<Category>>(
              initialData: [],
              create: (_) {
                return ReadCategoryDatabaseService().readCategory;
              }),
          StreamProvider<List<Promotion>>(
              initialData: [],
              create: (_) {
                return DatabasePromotion().promotions;
              }),
          StreamProvider<List<VersionController>>.value(
            initialData: [],
            value: ControllerDatabaseService().controller,
          ),
          StreamProvider<List<CompanyPromo>>(
              initialData: [],
              create: (_) {
                return ReadCompanyPromoService().readPromo;
              }),
          ChangeNotifierProvider(
            create: (context) => RangeData(),
          ),
          // ChangeNotifierProvider(
          //   create: (context) => LanguageProvider(),
          // ),

          ChangeNotifierProvider(
            create: (context) => LanguageProvider(),
          ),
          StreamProvider<List<Categories>>.value(
            initialData: [],
            value: CategoryDatabaseService().categories,
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///////////////////
  int netVersion = 0;
  /////////////////////////// App version
  int appVersion = 18;
  //////////////////////////  App version
  ///
  optionalUpdateActivator(BuildContext context, netVersionInput) {
    if (netVersionInput == 3 || netVersionInput == 4) {
      OptionalUpdate alert = OptionalUpdate();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }, 
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      // optionalUpdateActivator(context, netVersion);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<List<VersionController>>(context);
    if (controller.isNotEmpty) {
      netVersion = controller[0].sellerVersion - appVersion;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: controller.isEmpty
          ? Loading()
          : Scaffold(
              body: Stack(
                children: [
                  StreamProvider<UserAuth?>.value(
                    value: PhoneAuthServices().user,
                    initialData: null,
                    child: Splash(),
                  ),
                  Visibility(
                    visible: netVersion > 4,
                    child: ForcedUpdate(),
                  ),
                ],
              ),
            ),
    );
  }
}
