import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/ProductsUnderCategory/Product_list.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';
import '../../../Providers/AppInfo.dart';
import '../../../Shared/constants.dart';
import '../../components/emptyScreen.dart';


class ProductsWithCategory extends StatefulWidget {
  String category;
   ProductsWithCategory({super.key,required this.category});

  @override
  State<ProductsWithCategory> createState() => _ProductsWithCategoryState();
}

class _ProductsWithCategoryState extends State<ProductsWithCategory> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<List<Product>>(context);
      final appInformation = Provider.of<AppInformation>(context);
       var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(69.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(widget.category,
                    style: TextStyle(
                        fontSize:Dimensions.font26,
                        color: appInformation.appColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: Colors.white,
            // automaticallyImplyLeading: false,
            elevation: 0,
            iconTheme:  IconThemeData(color: appInformation.appColor,)),
      ),
      body: Container(
        height: ScreenSize().ScreenHeight(context),
        child: Column(
          children: [
            Expanded(
              child: product == null
                  ? Loading()
                  : product.isEmpty
                      ? EmptyScreen(context, Language().No_products[languageprov.LanguageIndex])
                      : ProductsUnderCategoryGrid(category:widget.category),
            ),
          ],
        ),
      ),
    );
  }
}
