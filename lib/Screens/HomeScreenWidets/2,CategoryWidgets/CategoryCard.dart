import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Providers/AppInfo.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Shared/constants.dart';
import '../../../Shared/customColors.dart';

class CategoryCard extends StatefulWidget {
  String text;
  String image;

  CategoryCard({super.key, required this.text, required this.image});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);

    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: CustomColors().blue),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: ScreenSize().ScreenWidth(context) / 2,
              height: ScreenSize().ScreenWidth(context) / 2.8,
              child: widget.image != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: widget.image,
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.newspaper_rounded,
                        size: 10,
                        color: CustomColors().blue,
                      ),
                    ),
            ),
            Center(
              child: Text(
                widget.text,
                style: TextStyle(
                    fontSize: 18.0,
                    color: CustomColors().darkBlue,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
