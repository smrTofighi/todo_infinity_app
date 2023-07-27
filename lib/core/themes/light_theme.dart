import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';
import '../values/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    fontFamily: FontFamily.samim,
    inputDecorationTheme: inputTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(LightColors.primary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        )),
  );
}

InputDecorationTheme inputTheme() {
  return InputDecorationTheme(
    fillColor: Colors.white,
    contentPadding:
        const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0, right: 14),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: LightColors.primary),
      borderRadius: BorderRadius.circular(6),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(),
      borderRadius: BorderRadius.circular(6),
    ),
    hintStyle: const TextStyle(fontSize: 12),
  );
}
