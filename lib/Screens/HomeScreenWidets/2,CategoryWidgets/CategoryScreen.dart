import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';
import '../../../Providers/AppInfo.dart';
import '../../../Shared/constants.dart';
import '../../components/emptyScreen.dart';
import 'SellersUnderCategory/Grid.dart';

class CategoryScreen extends StatefulWidget {
  String category;
   CategoryScreen({super.key,required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final sellers = Provider.of<List<SellerInformation>>(context);
      final appInformation = Provider.of<AppInformation>(context);
       var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(69.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(widget.category,
                    style: TextStyle(
                        fontSize:Dimensions.font26,
                        color: appInformation.appColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: Colors.white,
            // automaticallyImplyLeading: false,
            elevation: 0,
            iconTheme:  IconThemeData(color: appInformation.appColor,)),
      ),
      body: Container(
        height: ScreenSize().ScreenHeight(context),
        child: Column(
          children: [
            Expanded(
              child: sellers == null
                  ? Loading()
                  : sellers.isEmpty
                      ? EmptyScreen(context, Language().no_seller[languageprov.LanguageIndex] )
                      : SellersUnderCategoryGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
