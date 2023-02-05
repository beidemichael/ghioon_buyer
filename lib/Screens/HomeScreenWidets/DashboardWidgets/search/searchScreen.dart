import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Providers/search.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductGridListCard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';

class SearchData {
  List<String> searchResults;

  SearchData({required this.searchResults});
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Consumer<SearchProvider>(
          builder: (context, searchData, child) => TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: CustomColors().grey,
              ),
              suffixIcon: Icon(
                Icons.mic,
                color: CustomColors().grey,
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                searchData.setSearchResults(value, context);
              } else {
                search.searchResults = [];
              }
            },
          ),
        ),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, searchData, child) => ListView.builder(
          itemCount: searchData.searchResults.length,
          itemBuilder: (context, index) {
            // return ListTile(
            //   title: Text(searchData.searchResults[index].name),
            // );
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            product: searchData.searchResults[index],
                          )),
                );
              },
              child: ProductListCard(product: searchData.searchResults[index]),
            );
          },
        ),
      ),
    );
  }
}
