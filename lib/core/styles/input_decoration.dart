import 'package:flutter/material.dart';

import '../values/colors.dart';

//TODO: refacotor this class

class MyInputDecoration {
  static const InputDecoration textFieldAddEditTaskPage = InputDecoration(
    filled: true,
    fillColor: LightColors.backGround,
    labelText: 'چه برنامه ای داری؟',
    floatingLabelStyle: TextStyle(
      color: LightColors.grey,
    ),
    labelStyle: TextStyle(fontSize: 14),
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
  );
}
