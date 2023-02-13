// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:carousel_pro/carousel_pro.dart';
// import 'package:ghioon_buyer/Models/models.dart';
// import 'package:ghioon_buyer/Shared/constants.dart';
// import 'package:ghioon_buyer/Shared/customColors.dart';
// import 'package:provider/provider.dart';

// class CarouselSlider extends StatefulWidget {
//    CarouselSlider({super.key});

//   @override
//   State<CarouselSlider> createState() => _CarouselSliderState();
// }

// class _CarouselSliderState extends State<CarouselSlider> {
//   @override
//   Widget build(BuildContext context) {
//     final promo = Provider.of<List<CompanyPromo>>(context);

//     var items = [
//       promo.length == 0?Container(): Padding(
//       padding:  EdgeInsets.all(8.0),
//       child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(
//                     promo[0].image),
//                 fit: BoxFit.cover,
//               ),
//             border: Border.all(
//                 width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
//             color: CustomColors().white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//                 bottomRight: Radius.circular(15),
//                 bottomLeft: Radius.circular(15)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.9),
//                 spreadRadius: 2,
//                 blurRadius: 3,
//                 offset: Offset(0, 2), // changes position of shadow
//               ),
//             ],
//           ),
//           ),
//     ),
    
//    promo.length == 0?Container(): Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(
//                      promo[1].image),
//                 fit: BoxFit.cover,
//               ),
//             border: Border.all(
//                 width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
//             color: CustomColors().white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//                 bottomRight: Radius.circular(15),
//                 bottomLeft: Radius.circular(15)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.9),
//                 spreadRadius: 2,
//                 blurRadius: 3,
//                 offset: Offset(0, 2), // changes position of shadow
//               ),
//             ],
//           ),
//       ),
//     ),
//     promo.length == 0?Container(): Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(
//                     promo[2].image),
//                 fit: BoxFit.cover,
//               ),
//             border: Border.all(
//                 width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
//             color: CustomColors().white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//                 bottomRight: Radius.circular(15),
//                 bottomLeft: Radius.circular(15)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.9),
//                 spreadRadius: 2,
//                 blurRadius: 3,
//                 offset: Offset(0, 2), // changes position of shadow
//               ),
//             ],
//           ),
        
//           ),
//     )
//     ];
//     return Padding(
//       padding:  EdgeInsets.all(5.0),
//       child: Container(
//       height:MediaQuery.of(context).size.height*0.23,
//       child: Carousel(
//         boxFit: BoxFit.cover,
//         images:promo,
//         autoplay: true,
//         animationCurve: Curves.fastOutSlowIn,
//         animationDuration: Duration(milliseconds: 1000),
//         // dotSize: 8.0,
//         // indicatorBgPadding:10

//       ),

//     ),
//     );
//   }
// }