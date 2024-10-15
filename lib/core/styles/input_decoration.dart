import 'package:flutter/material.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';

import '../values/colors.dart';


class AppInputDecoration {
  AppInputDecoration._();
  static  InputDecoration textFieldAddEditTaskPage = InputDecoration(
    filled: true,
    fillColor: LightColors.backGround,
    labelText: 'چه برنامه ای داری؟',
    floatingLabelStyle: const TextStyle(
      color: LightColors.grey,
    ),
    labelStyle: const TextStyle(fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.radius)
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: LightColors.primary),
      borderRadius: BorderRadius.circular(AppDimens.radius)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.radius)
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(AppDimens.radius)
    ),
    disabledBorder: InputBorder.none,
  );

  static InputDecoration textFieldDescription = InputDecoration(
    filled: true,
    fillColor: LightColors.backGround,
    labelText: 'توضیحات',
    floatingLabelStyle: const TextStyle(
      color: LightColors.grey,
    ),
    labelStyle: const TextStyle(fontSize: 14),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: LightColors.primary),
        borderRadius: BorderRadius.circular(AppDimens.radius)
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius)
    ),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(AppDimens.radius)
    ),
    disabledBorder: InputBorder.none,
  );
}
