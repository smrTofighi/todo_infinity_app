import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';
import '../values/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: false,
    fontFamily: FontFamily.samim,
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightColors.backGround,
    shadowColor: Colors.black.withOpacity(0.1),
    splashColor: LightColors.primaryBG,
    cardColor: LightColors.card,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: LightColors.black),
      backgroundColor: LightColors.backGround,
      elevation: 0,
    ),
   
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: LightColors.primaryBG,),
    inputDecorationTheme: inputTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    bottomAppBarTheme: const BottomAppBarTheme(color: LightColors.white),
    iconTheme: const IconThemeData(
      color: LightColors.black

    )
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
