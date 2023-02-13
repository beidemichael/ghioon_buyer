import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/ProductGridListCard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Services/Database/Product/readProduct.dart';

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot>? _products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
              hintText: "Search for products",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          onChanged: (value) {
            setState(() {
              if (value.isNotEmpty) {
                _products = FirebaseFirestore.instance
                    .collection("Products")
                    // .where("name", isEqualTo: value)
                    .where("name".toLowerCase(),
                        isGreaterThanOrEqualTo: value.toLowerCase())
                    .where("name".toLowerCase(),
                        isLessThan: value.toLowerCase() + "\uf8ff")
                    .get();
              }
              // _products = ReadProductDatabaseService(productName: value).readSearchProduct();
            });
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> product =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(product["name"] ?? ""),
                  );
                  // return GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ProductDetail(
                  //                 product: Product.fromMap(product),
                  //               )),
                  //     );
                  //   },
                  //   child: ProductListCard(product: Product.fromMap(product)),
                  // );
                },
              );
            } else {
              return Center(
                child: Text(
                  "No products found",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
