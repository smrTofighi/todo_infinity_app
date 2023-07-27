import 'package:flutter/cupertino.dart';

extension SizedBoxExtension on double {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );
  SizedBox get width => SizedBox(
        width: toDouble(),
      );
}