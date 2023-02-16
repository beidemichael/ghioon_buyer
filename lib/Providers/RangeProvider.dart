import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

// final List<Range> initialData = [];

class RangeData with ChangeNotifier {
  // List<Range> Ranges = [];
  final ImagePicker _picker = ImagePicker();

  //variables for dropdown
  String? selectedValue = null;
  String? selectedCatagoryValue = null;

  String selected_collection = "";

  removeSelectedValue() {
    selectedValue = null;
  }

  removeSelectedCatagoryValue() {
    selectedCatagoryValue = '';
  }

  addSelectedCatagoryValue(String value) {
    selectedCatagoryValue = value;
  }
}
