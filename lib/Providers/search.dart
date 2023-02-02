import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:provider/provider.dart';

class SearchProvider with ChangeNotifier {
  List<Product> searchResults = [];

  // List<String> get searchResults => searchResults;

  setSearchResults(String searchValue, BuildContext context) async {
    final products = Provider.of<List<Product>>(context, listen: false);
    print(products[0].name);
    searchResults = getSearchResults(searchValue, products);
    print("===============");
    // print(searchResults[0]);
    print(searchResults.length);

    notifyListeners();
  }

  List<Product> getSearchResults(String searchTerm, List<Product> product) {
    return product
        .where((model) =>
            model.name.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList(); //model.name == searchTerm
  }
}
