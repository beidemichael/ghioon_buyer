import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';

class CollectionList extends StatelessWidget {
  CollectionList(
      {Key? key, required this.title, this.desc = '',  this.image = ''})
      : super(key: key);
  final String title;
  String desc;
  String image;

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Categories>>(context);
    for(Categories x in categories){
      if (x.type == title){
        image = x.image;
      }

    }
    return Container(
      height: ScreenSize().ScreenWidth(context) / 3.5,
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
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                color: CustomColors().blue,
                fontWeight: FontWeight.w700),
          ),
          leading: image != ''
              ? SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
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
                      //errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.shop,
                    size: 50,
                  ),
                ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.chevronRight),
            iconSize: 40,
            color: CustomColors().blue,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(
              children: [
                Text(
                  desc.characters.length > 9
                      ? desc.replaceRange(10, desc.length, '...')
                      : desc,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: CustomColors().black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const Text("."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
