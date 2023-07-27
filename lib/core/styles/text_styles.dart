import 'package:flutter/material.dart';
import 'package:todo_infinity_app/core/values/colors.dart';

import '../../gen/fonts.gen.dart';

class LightTextStyles {
  static TextStyle normall12(Color color) {
    return TextStyle(fontSize: 12, color: color);
  }

  static TextStyle bold28Fanavari(Color color) {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: color,
      fontFamily: FontFamily.fanavari,
    );
  }

  static TextStyle normal10(Color color) {
    return TextStyle(fontSize: 10, color: color);
  }

  static const TextStyle categoryNameTitleBlack = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Colors.black,
    fontFamily: FontFamily.samim,
  );
  static const TextStyle bigTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Colors.black,
    fontFamily: FontFamily.samim,
  );

  static const TextStyle bigTextWhite = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28.0,
    color: Colors.white,
  );

  static const TextStyle importanceTextTaskListPageComplete =
      TextStyle(fontSize: 11, color: LightColors.grey);
  static const TextStyle importanceTextTaskListPageAll =
      TextStyle(fontSize: 11, color: LightColors.black);

  static const TextStyle titleOfAppBar = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleOfBottomSheet =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
}
