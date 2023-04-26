import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/cartProvider.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Providers/search.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/ProductForGrid.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/carousel.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/carousel_slider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/search/searchFirebase.dart';
//import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/search/searchScreen_old.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/search/searchbar.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/topcatagory.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:ghioon_buyer/Shared/language.dart';

import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  BuildContext context;
  Dashboard({super.key, required this.context});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final order = Provider.of<CartProvider>(context, listen: false);
    order.context = widget.context;
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    final search = Provider.of<SearchProvider>(context);
    var languageprov = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              // height: 100, // Set a fixed height for the GestureDetector
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.width10,
                  Dimensions.width20,
                  Dimensions.width10,
                  Dimensions.width10,
                ),
                child: GestureDetector(
                  onTap: () {
                    search.searchResults.clear();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductSearch(),
                      ),
                    );
                  },
                  child: SearchBar(),
                ),
              ),
            ),
            HorizontalSlider(),
            Carousel_Slider(),
            Container(
              color: Colors.transparent,
              // height: double.infinity,
              child: products.length == 0
                  ? EmptyScreen(
                      context,
                      (Language().No_products[languageprov.LanguageIndex]),
                    )
                  : ProductForGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
