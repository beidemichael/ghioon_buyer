import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:intl/intl.dart';

class productWidget extends StatelessWidget {
  const productWidget({Key? key, required this.width, required this.product, required this.category})
      : super(key: key);

  final double width;
  final Product product;
  final String category;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
      child: Container(
        height: width / 4.5,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListTile(
              title: Text(
                product.name,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: Dimensions.font23,
                    color: CustomColors().black,
                    fontWeight: FontWeight.w700),
              ),
              leading: product.image.isNotEmpty
                  ? Container(
                      width: width / 7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: product.image[0],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey[300]!),
                                  value: downloadProgress.progress),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        FontAwesomeIcons.store,
                        size: 70,
                        color: CustomColors().blue,
                      ),
                    ), //Image.asset('assets/images/head.png'),
              subtitle: Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(product.created.toDate().toUtc()),
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: CustomColors().grey,
                    fontSize: Dimensions.font14,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Text("Views: "+  product.viewCountTime.length.toString(),
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: CustomColors().black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
      ),
    );
  }
}
