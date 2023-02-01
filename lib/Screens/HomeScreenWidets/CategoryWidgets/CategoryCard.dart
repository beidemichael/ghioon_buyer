import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Providers/AppInfo.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryCard extends StatefulWidget {
  String text;

  CategoryCard({super.key, required this.text});

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
        border: Border.all(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Icon(
              FontAwesomeIcons.angleRight,
              color: appInformation.appColor,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
