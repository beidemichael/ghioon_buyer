import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/AppInfo.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/2,CategoryWidgets/CategoryScreen.dart';
import 'package:ghioon_buyer/Services/Database/SellerDatabase/sellerDatabase.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';

class HorizontalSlider extends StatefulWidget {
  HorizontalSlider();

  @override
  State<HorizontalSlider> createState() => _HorizontalSliderState();
}

class _HorizontalSliderState extends State<HorizontalSlider> {
  @override
  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);
    final catagory = Provider.of<List<Category>>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Container(
        height: ScreenSize().ScreenHeight(context) * 0.07,
        child: catagory.length != 0
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catagory.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the details page for the tapped container
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StreamProvider<List<SellerInformation>>.value(
                            initialData: [],
                            value: SellerDatabaseService(
                                    businessType: catagory[index].type)
                                .sellers,
                            child: CategoryScreen(
                              category: catagory[index].type,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      // width: 100,
                      //height: 10,
                      //height: ScreenSize().ScreenHeight(context) * 0.5,
                      decoration: BoxDecoration(
                        color: CustomColors().blue,
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 224, 224, 224)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 18),
                        child: Center(
                          child: Text(
                            catagory[index].type,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenSize().ScreenWidth(context) *
                                  0.035, // 13.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : ListView(),
      ),
    );
  }
}
