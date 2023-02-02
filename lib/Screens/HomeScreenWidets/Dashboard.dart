import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/search.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductForGrid.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/carousel.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/search/searchScreen.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/search/searchbar.dart';
import 'package:ghioon_buyer/Screens/components/emptyScreen.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    final search = Provider.of<SearchProvider>(context);
    return Scaffold(
      body: Container(
        height: ScreenSize().ScreenHeight(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 8),
              child: GestureDetector(
                  onTap: () {
                    search.searchResults.clear();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                  child: SearchBar()),
            ),
            SizedBox(
              height: 100,
            ),
            Carousel(),
            Expanded(
              child: products.length == 0
                  ? EmptyScreen(context, 'No Products.')
                  : ProductForGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
