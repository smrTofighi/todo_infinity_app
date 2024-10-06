import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/strings.dart';

deleteCategoryDialog(int index, BuildContext context) {
  var width = MediaQuery.of(context).size.width;

  Get.defaultDialog(
    barrierDismissible: false,
    backgroundColor: LightColors.card,
    buttonColor: LightColors.primary,
    confirm: Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      height: 30,
      width: width / 4,
      child: ElevatedButton(
        onPressed: () {
          //controller.deleteCategory(index);
          Get.back();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.redAccent),
        ),
        child: const Text(PersianStrings.delete),
      ),
    ),
    cancel: Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      height: 30,
      width: width / 4,
      child: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.green),
        ),
        child: const Text(PersianStrings.cancel),
      ),
    ),
    title: '',
    titleStyle: const TextStyle(fontSize: 10),
    titlePadding: const EdgeInsets.all(0),
    //middleText: 'دسته بندی ${controller.categoryList[index].title} حذف شود؟',
    radius: AppDimens.radius,
  );
}
