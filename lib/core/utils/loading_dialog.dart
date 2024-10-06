import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/widgets/loading.dart';
import '../values/colors.dart';

loadingDialog() {
  Get.dialog(
    const Center(
      child: Loading(color: LightColors.white),
    ),
    barrierDismissible: false,
    
  );
}