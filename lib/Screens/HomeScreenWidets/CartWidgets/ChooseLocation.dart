// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

import '../../../../../Models/models.dart';
import '../../../Shared/customColors.dart';

class ChooseDeliveryLocation extends StatefulWidget {
  const ChooseDeliveryLocation({super.key});

  @override
  State<ChooseDeliveryLocation> createState() => _ChooseDeliveryLocationState();
}

class _ChooseDeliveryLocationState extends State<ChooseDeliveryLocation> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<List<Addresses>>(context);

    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: loading
          ? SpinKitCircle(
              color: CustomColors().blue,
              size: 50.0,
            )
          : Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Choose Delivery Address',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.56,
                    //  height: 400,

                    child: address.length != 0
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: address.length,
                            itemBuilder: (contextt, index) {
                              return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });

                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 13, right: 13),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[100],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            offset: const Offset(2, 2),
                                            blurRadius: 3,
                                            spreadRadius: 1,
                                          ),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Icon(
                                                Icons.location_on,
                                                color: CustomColors().blue,
                                                size: 30,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Marquee(
                                                      backDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  500),
                                                      directionMarguee:
                                                          DirectionMarguee
                                                              .oneDirection,
                                                      child: Text(
                                                        address[index].name,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: CustomColors()
                                                              .blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: (MediaQuery.of(context).size.height *
                                        0.56 /
                                        2) -
                                    (4 + 45),
                              ),
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
              ],
            ),
    );
  }
}
