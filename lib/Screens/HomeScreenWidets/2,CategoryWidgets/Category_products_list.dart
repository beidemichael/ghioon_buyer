import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:provider/provider.dart';
import '../../../Providers/AppInfo.dart';
import '../../../Shared/constants.dart';
import '../../components/emptyScreen.dart';
import 'ProductsUnderCategory/Grid.dart';

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
                        fontSize: 28.0,
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
                      ? EmptyScreen(context, 'No Products.')
                      : SellersUnderCategoryGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
