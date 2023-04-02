import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';
class ProductListCard extends StatelessWidget {
  const ProductListCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.;
     var languageprov = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),

          // shadowColor: CustomColors().black,
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Container(
                  width: ScreenSize().ScreenWidth(context) / 2,
                  height: ScreenSize().ScreenWidth(context) / 2.8,
                  child: product.image[0] != ''
                      ? ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
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
                        )
                      : Center(
                          child: Icon(
                            Icons.newspaper_rounded,
                            size: 10,
                            color: CustomColors().blue,
                          ),
                        ),
                ),
                ListTile(
                  title: Text(
                    product.name,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: Dimensions.font16,
                        color: CustomColors().blue,
                        fontWeight: FontWeight.w700),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      children: [
                        Text(
                         // 'ETB ' + product.price[0].toString(),
                         Language().negotiable[languageprov.LanguageIndex],
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: CustomColors().black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                )
              ]))),
    );
  }
}
