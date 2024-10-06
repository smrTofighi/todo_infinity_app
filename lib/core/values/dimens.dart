import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppDimens {
  AppDimens._();
  static double infinity = double.infinity;
  static double width = Get.width;
  static double height = Get.height;
  static double radius = 8;

  static double small = 8;
  static double medium = 12;
  static double high = 16;

  static Size sizeOfDevice(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }
}
