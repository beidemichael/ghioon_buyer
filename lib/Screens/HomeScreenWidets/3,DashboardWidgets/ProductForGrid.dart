import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
//import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/ProductGridListCard.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:provider/provider.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

class ProductForGrid extends StatelessWidget {
  const ProductForGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Products");
    final products = Provider.of<List<Product>>(context);
    print(products);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
        child: products.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: (2.5 / 3),
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: products.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                  product: products[index],
                                )),
                      );
                    },
                    child: ProductListCard(product: products[index]),
                  );
                },
              )
            : EmptyScreen(context, "No Products in Store"),
      ),
    );
  }
}