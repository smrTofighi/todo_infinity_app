import 'package:flutter/material.dart';
import 'package:todo_infinity_app/core/values/colors.dart';

class MyTextStyles {
  static const TextStyle categoryTitleBlack = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black);
  static const TextStyle bigTextWhite = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 28.0, color: Colors.white);

  static const TextStyle importanceTextTaskListPageComplete =
      TextStyle(fontSize: 11, color: SolidColors.grey);
  static const TextStyle importanceTextTaskListPageAll =
      TextStyle(fontSize: 11, color: SolidColors.black);

  static const TextStyle titleOfAppBar = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleOfBottomSheet =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
}
