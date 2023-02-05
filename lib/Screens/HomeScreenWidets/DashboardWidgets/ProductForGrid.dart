import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
//import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductGridListCard.dart';
import 'package:provider/provider.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

class ProductForGrid extends StatelessWidget {
  const ProductForGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
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
        ),

        // GridView.count(
        //     childAspectRatio: (2.5 / 3),
        //     shrinkWrap: true,
        //     physics: const BouncingScrollPhysics(
        //         parent: AlwaysScrollableScrollPhysics()),
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 4.0,
        //     mainAxisSpacing: 8.0,
        //     children: List.generate(products.length, (index) {
        //       return
        //     })),
      ),
    );
  }
}
