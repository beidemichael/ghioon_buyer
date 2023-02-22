import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:ghioon_buyer/Providers/FeedbackProvider.dart';
import 'package:ghioon_buyer/Screens/components/BlueButton.dart';
import 'package:ghioon_buyer/Screens/components/alertDialog.dart';
import 'package:ghioon_buyer/Screens/components/loadingWidget.dart';
import 'package:ghioon_buyer/Screens/components/textFormField.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';

import 'package:provider/provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<FeedbackData>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('Feedback',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: CustomColors().white,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: IconThemeData(color: CustomColors().white)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Flexible(
                    child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: CustomColors().white),
                    color: CustomColors().blue,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(children: [
                      Text(
                        'Give us any comment and feedback for our service',
                        style: TextStyle(
                            fontSize: 25, color: CustomColors().white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldFeeDescription(
                          "Feedback", appState.feedbackDescription, "Feedback"),
                      Visibility(
                        visible: !appState.feedbackDescriptionFilled,
                        child: const Center(
                          child: Text(
                            "Please fill all inputs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            //Check if Product Name and Description is filled
                            appState.checkFeedbackDescription(context);
                            //Check if Range and Fixed fields are filled
                            //If All fields are filled==>

                            if (appState.feedbackDescriptionFilled) {
                              appState.isLoading = true;
                              // AddProductDetailLogic().showDialog(context);

                              PopupDialog alert = PopupDialog(
                                  "Are You Sure you want to send this feedback? (your user id will be sent for feedback reply)",
                                  () {
                                print(appState.isLoading);
                                appState.sendFeedback(context).then(
                                    (value) => appState.isLoading = false);
                              }, () {});

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          },
                          child: BlueButtonWhite(text: 'Send Feedback'))
                    ]),
                  ),
                )),
              ],
            ),
          ),
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: appState.isLoading,
                child: LoadingWidget(
                    height: height, message: "Sending feedback . . ."),
              ))
        ],
      ),
    );
  }
}
