import 'package:flutter/cupertino.dart';

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
}
