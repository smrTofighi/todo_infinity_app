import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/modules/category/category_controller.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/strings.dart';

deleteCateogryDialog(int index, BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  CategoryController controller = Get.find<CategoryController>();

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
          backgroundColor: MaterialStateProperty.all(Colors.redAccent),
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
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        child: const Text(PersianStrings.cancel),
      ),
    ),
    title: '',
    titleStyle: const TextStyle(fontSize: 10),
    titlePadding: const EdgeInsets.all(0),
    middleText: 'دسته بندی ${controller.categoryList[index].title} حذف شود؟',
    radius: Dimens.radius,
  );
}
