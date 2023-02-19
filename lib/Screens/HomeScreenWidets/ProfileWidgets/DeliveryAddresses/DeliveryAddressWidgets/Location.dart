import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../Shared/customColors.dart';
import 'adressAlert/are_you_sure_you_want_to_delete.dart';

class locations extends StatelessWidget {
  String docId;
  String location;

  locations(
    this.location,
    this.docId,
  );
  areYouSureYouWantToDelete(BuildContext context, String documentId) {
    AdressDeleteBlurDialog alert = AdressDeleteBlurDialog(
      documentId: documentId,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
 
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: InkWell(
        splashColor: Colors.amberAccent,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(2, 2),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Marquee(
                            backDuration: const Duration(milliseconds: 500),
                            directionMarguee: DirectionMarguee.oneDirection,
                            child: Text(
                              location,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors().blue,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  areYouSureYouWantToDelete(context, docId);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.delete,
                    size: 20,
                    color: CustomColors().blue,
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
