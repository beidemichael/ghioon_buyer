import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/RangeProvider.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/CategoryWidgets/SellersUnderCategory/StoreProfile/Store_profile_components/collection/CollectionDetail/collectionDetailPage.dart';
import 'package:ghioon_buyer/Services/Database/collections/readCollectionItems.dart';

import 'package:provider/provider.dart';

class CollectionDetailProvider extends StatefulWidget {
  String sellerID;
  String collection_name;
  String collection_description;

  CollectionDetailProvider(
      {super.key,
      required this.sellerID,
      required this.collection_name,
      required this.collection_description});

  @override
  State<CollectionDetailProvider> createState() =>
      _CollectionDetailProviderState();
}

class _CollectionDetailProviderState extends State<CollectionDetailProvider> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<RangeData>(context);
    // final seller = Provider.of<List<SellerInformation>>(context);

    return StreamProvider<List<CollectionItems>>.value(
        initialData: [],
        value: ReadCollectionItemsDatabaseService(
                userUid: widget.sellerID,
                collection: appState.selectedCatagoryValue)
            .readCollectionItems,
        child: CollectionDetail(
            collection_name: widget.collection_name,
            collection_description: widget.collection_description));
  }
}
