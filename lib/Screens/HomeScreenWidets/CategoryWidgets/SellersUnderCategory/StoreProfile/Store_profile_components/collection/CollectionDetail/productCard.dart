import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList(
      {Key? key,
      required this.title,
      required this.stock,
      required this.image,
      required this.edit,
      required this.item,
      required this.index})
      : super(key: key);

  final String title;
  final String stock;
  final List image;
  final bool edit;
  final int index;
  final item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        // height: ScreenSize().ScreenWidth(context) / 3.5,
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
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  color: CustomColors().blue,
                  fontWeight: FontWeight.w700),
            ),
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: Container(
                //image
                width: ScreenSize().ScreenWidth(context) / 3.5,
                height: ScreenSize().ScreenWidth(context) / 3.5,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: image[0] != ''
                    ? ClipRRect(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: image[0],
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
                      )
                    : Center(
                        child: Icon(
                          Icons.newspaper_rounded,
                          size: 10,
                          color: Colors.grey[400],
                        ),
                      ),
              ),
            ), //Image.asset('assets/images/head.png'),

            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Row(
                children: [
                  Text(
                    stock.toString(),
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: CustomColors().black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(" In Stock"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
