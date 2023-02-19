import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../Models/models.dart';
import 'DeliveryAddressWidgets/MapAddress.dart';
import 'DeliveryAddressWidgets/Location.dart';
import 'DeliveryAddressWidgets/adressAlert/are_you_sure_you_want_to_delete.dart';

class deliveryaddress extends StatefulWidget {
  const deliveryaddress({super.key});

  @override
  State<deliveryaddress> createState() => _deliveryaddressState();
}

class _deliveryaddressState extends State<deliveryaddress> {
  @override
  Widget build(BuildContext context) {
    
    final address = Provider.of<List<Addresses>>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: CustomColors().blue,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Saved Delivery Addresses',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 400
                ? 400
                : MediaQuery.of(context).size.width * .75,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height * 0.56,
                    //  height: 400,

                    child: address.length != 0
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: address.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, left: 13, right: 13),
                                child: locations(address[index].name,
                                    address[index].documentId),
                              );
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   height: (MediaQuery.of(context).size.height *
                              //           0.56 /
                              //           2) -
                              //       (4 + 45),
                              // ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13.0),
                                child: Text('You have no saved address.',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 30, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     MediaQuery.of(context).size.width<500? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MapAddress(),
                            ),
                          );
                        },
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:  CustomColors().blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(5, 5),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ]),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 35,
                            )),
                      ):Container(),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // )
              ],
            ),
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   backgroundColor: Color(0xffDA003F),
      //   child: const Icon(
      //     Icons.add,
      //     size: 40,
      //     shadows: <Shadow>[Shadow(color: Colors.black, blurRadius: 15.0)],
      //   ),
      // ),
    );
  }
}
