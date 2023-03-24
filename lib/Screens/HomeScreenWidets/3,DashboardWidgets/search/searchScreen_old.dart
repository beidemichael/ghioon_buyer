import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Providers/search.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/ProductGridListCard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Services/Database/SellerDatabase/sellerDatabase.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
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
      // appBar: AppBar(
      //   title: Consumer<SearchProvider>(
      //     builder: (context, searchData, child) => TextField(
      //       decoration: InputDecoration(
      //         hintText: "Search...",
      //         border: OutlineInputBorder(
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(25.0),
      //           ),
      //         ),
      //         prefixIcon: Icon(
      //           Icons.search,
      //           color: CustomColors().grey,
      //         ),
      //         suffixIcon: Icon(
      //           Icons.mic,
      //           color: CustomColors().grey,
      //         ),
      //       ),
      //       onChanged: (value) {
      //         if (value.isNotEmpty) {
      //           searchData.setSearchResults(value, context);
      //         } else {
      //           search.searchResults = [];
      //         }
      //       },
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 8),
            child: Consumer<SearchProvider>(
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
          Consumer<SearchProvider>(
            builder: (context, searchData, child) => Expanded(
              // height: ScreenSize().ScreenHeight(context),
              child: ListView.builder(
                itemCount: searchData.searchResults.length,
                itemBuilder: (context, index) {
                  // return ListTile(
                  //   title: Text(searchData.searchResults[index].name),
                  // );
                  return GestureDetector(
                    onTap: () async {
                      var phone = await SellerDatabaseService().getSellerPhone(
                          searchData.searchResults[index].userUid);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                  product: searchData.searchResults[index],
                                  phone: phone,
                                )),
                      );
                    },
                    child: ProductListCard(
                        product: searchData.searchResults[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
