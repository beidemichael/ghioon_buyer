import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Providers/AppInfo.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/CategoryWidgets/CategoryScreen.dart';
import 'package:ghioon_buyer/Services/Database/SellerDatabase/sellerDatabase.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';

class HorizontalSlider extends StatelessWidget {
  HorizontalSlider();

  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);
    final catagory = Provider.of<List<Category>>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Container(
        height: ScreenSize().ScreenHeight(context) * 0.08,
        child: ListView.builder(
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
                width: 100,
                //height: 10,
                //height: ScreenSize().ScreenHeight(context) * 0.5,
                decoration: BoxDecoration(
                  color: CustomColors().blue,
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 224, 224, 224)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    catagory[index].type,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContainerDetails extends StatelessWidget {
  final String item;

  ContainerDetails({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Details'),
      ),
      body: Center(
        child: Text(
          item,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
