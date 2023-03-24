import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/AppInfo.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/ProductGridListCard.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/3,DashboardWidgets/productDetail.dart';
import 'package:ghioon_buyer/Services/Database/Product/readProduct.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Services/Database/SellerDatabase/sellerDatabase.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot>? _products;

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          hintText:
                              Language().search[languageprov.LanguageIndex],
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            _products = FirebaseFirestore.instance
                                .collection("Products")
                                .where("name", isGreaterThanOrEqualTo: value)
                                // .where("name", isLessThan: value + "\uf8ff")
                                .where("name",
                                    isLessThan: value.substring(
                                            0, value.length - 1) +
                                        String.fromCharCode(
                                            value.codeUnitAt(value.length - 1) +
                                                1))
                                // .where("name".toLowerCase(),
                                //     isGreaterThanOrEqualTo: value.toLowerCase())

                                .get();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
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
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return searchResultWidget(product: product);
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            Language().No_products[languageprov.LanguageIndex],
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class searchResultWidget extends StatelessWidget {
  const searchResultWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * .75,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: Container(
            width: ScreenSize().ScreenWidth(context) * 0.2,
            //height: ScreenSize().ScreenWidth(context) * 0.2,
            child: CachedNetworkImage(
              imageUrl: product["image"][0],
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          title: Text(product["name"],
              style: TextStyle(
                  fontSize: ScreenSize().ScreenWidth(context) * 0.05,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          subtitle: Text('\ETB ${product["price"][0].toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: ScreenSize().ScreenWidth(context) * 0.04,
                  fontWeight: FontWeight.w500)),
          trailing: Icon(
            FontAwesomeIcons.angleRight,
            color: appInformation.appColor,
            size: 25,
          ),
          onTap: () async {
            var phone = await SellerDatabaseService()
                .getSellerPhone(Product.fromMap(product).userUid);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetail(
                      product: Product.fromMap(product), phone: phone)),
            );
          },
        ),
      ),
    );
  }
}
