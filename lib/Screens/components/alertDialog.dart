// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../Shared/customColors.dart';

class PopupDialog extends StatelessWidget {
  String message;
  VoidCallback yesCallBack;
  VoidCallback noCallBack;

  PopupDialog(this.message, this.yesCallBack, this.noCallBack);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
            width: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Ghioon",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25.0),
                      child: Text(
                        message,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w300),
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: Text('NO',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context).pop();
                          yesCallBack();
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: CustomColors().blue,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                          ),
                          child: const Center(
                            child: Text('YES',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

Future buildShowDialog(BuildContext context, String title, String text,
    VoidCallback yesCallBack, VoidCallback noCallBack) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25.0),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w300),
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: Text('NO',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          yesCallBack();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: CustomColors().blue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(20.0)),
                          ),
                          child: Center(
                            child: Text('YES',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

Future buildShowDoneDialog(
    BuildContext context, String title, String text, VoidCallback yesCallBack) {
  return showDialog(
      //useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Divider(
                  color: CustomColors().grey,
                  height: 4.0,
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25.0),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: CustomColors().grey,
                            fontWeight: FontWeight.w300),
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          yesCallBack();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: CustomColors().blue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(20.0)),
                          ),
                          child: Center(
                            child: Text('Ok',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: CustomColors().white,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
