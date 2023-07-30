import 'package:flutter/material.dart';

import '../values/colors.dart';
import '../values/dimens.dart';

class AppBoxDecoration {
  AppBoxDecoration._();

  static BoxDecoration whiteRadius = BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Dimens.radius),
      topRight: Radius.circular(Dimens.radius),
    ),
    color: LightColors.backGround,
  );

  static BoxDecoration taskWidgetDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimens.radius),
    color: LightColors.card,
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5,
          spreadRadius: 0.2)
    ],
  );
}
