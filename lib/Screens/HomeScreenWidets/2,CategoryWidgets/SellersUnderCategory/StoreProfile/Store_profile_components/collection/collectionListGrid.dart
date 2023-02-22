import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/RangeProvider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/SellersUnderCategory/StoreProfile/Store_profile_components/collection/cOllectionaddPro.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/SellersUnderCategory/StoreProfile/Store_profile_components/collection/collection_card.dart';

class CollectionListGrid extends StatelessWidget {
  const CollectionListGrid({
    Key? key,
    required this.sellers,
    required this.appState,
  }) : super(key: key);

  final List<SellerInformation> sellers;
  final RangeData appState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: sellers[0].collections.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              appState.addSelectedCatagoryValue(sellers[0].collections[index]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CollectionDetailProvider(
                      sellerID: sellers[0].userUid,
                      collection_name: sellers[0].collections[index],
                      collection_description:
                          sellers[0].collection_description[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CollectionList(
                  title: sellers[0].collections[index],
                  desc: sellers[0].collection_description.isNotEmpty
                      ? sellers[0].collection_description[index]
                      : '',
                  image: sellers[0].collection_images[index]),
            ),
          );
        },
      ),
    );
  }
}
