import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:ghioon_buyer/Shared/dimensions.dart';
import 'package:provider/provider.dart';

Widget TextFormFieldWithIcon(String label, String hintText,
    TextEditingController control, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
      keyboardType: TextInputType.text,
      controller: control,
      //initialValue: autoAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.blue),
          gapPadding: 10,
        ),
        suffixIcon: Icon(
          icon,
          size: 20.0,
          color: Colors.blue,
        ),
      ),
    ),
  );
}

Widget TextFormFieldWithOutIcon(String hintText, TextEditingController control,
    String header, TextInputType keyboard) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header,
            style: const TextStyle(
                fontSize: 22.0,
                color: Color.fromARGB(255, 107, 107, 107),
                fontWeight: FontWeight.w500)),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: keyboard,
          controller: control,
          //initialValue: autoAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: CustomColors().blue),
              gapPadding: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

//Text widget for with out header label
Widget TextFormFieldWithOutLabel(
    String hintText, TextEditingController control, TextInputType keyboard) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: keyboard,
          controller: control,
          //initialValue: autoAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20, vertical: Dimensions.width15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: CustomColors().blue),
              gapPadding: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

//Text widget for Product name in add product
Widget TextFormFieldProduct(
    String hintText, TextEditingController control, String header) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: control,
          //initialValue: autoAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: CustomColors().blue),
              gapPadding: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget TextFormFieldProductInitialValue(
    TextEditingController control, TextInputType keyboard) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          // initialValue: init,
          keyboardType: keyboard,
          controller: control,
          //initialValue: autoAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: CustomColors().blue),
              gapPadding: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

//Text widget for Product description in add product
Widget TextFormFieldProDescription(
    String hintText, TextEditingController control, String header) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: 10, // <-- SEE HERE
          minLines: 5, // <-- SEE HERE
          keyboardType: TextInputType.text,
          controller: control,
          //initialValue: autoAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: CustomColors().blue),
              gapPadding: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

//Text widget for feedback description in add product
Widget TextFormFieldFeeDescription(
    String hintText, TextEditingController control, String header) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: 20, // <-- SEE HERE
          minLines: 15, // <-- SEE HERE
          keyboardType: TextInputType.text,
          controller: control,
          //initialValue: autoAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            filled: true,
            fillColor: CustomColors().white,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 25),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: CustomColors().blue),
              gapPadding: 10,
            ),
          ),
        ),
      ],
    ),
  );
}
