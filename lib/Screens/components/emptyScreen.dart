import 'package:flutter/material.dart';

Widget EmptyScreen(BuildContext context, text) {
  return Container(
    color: Colors.white,
    height: MediaQuery.of(context).size.height,
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/undraw_No_data_re_kwbl.png',
            height: MediaQuery.of(context).size.height * .3,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(text,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}
