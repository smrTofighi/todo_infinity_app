import 'package:flutter/material.dart';
import 'package:todo_infinity_app/core/gen/fonts.gen.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
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
   
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: LightColors.primaryBG,),
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
        backgroundColor: WidgetStateProperty.all(LightColors.primary),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        )),
  );
}

InputDecorationTheme inputTheme() {
  return InputDecorationTheme(
    fillColor: Colors.white,
    
    errorStyle: LightTextStyles.normal10(LightColors.redText),
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
