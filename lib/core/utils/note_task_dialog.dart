import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/strings.dart';

noteTaskDialog(BuildContext context) {
  final TaskViewModel taskVM = Get.find<TaskViewModel>();
  final TextEditingController textEditingController = TextEditingController();
  var width = MediaQuery.of(context).size.width;
  Get.defaultDialog(
    contentPadding: EdgeInsets.all(AppDimens.small),
    barrierDismissible: false,
    backgroundColor: LightColors.card,
    buttonColor: LightColors.primary,
    content: TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: 'توضیحات مأموریت',
        hintStyle: LightTextStyles.normal12(LightColors.greyText),
      ),
      style: LightTextStyles.normal12(LightColors.blackText),
    ),
    confirm: Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      height: 45,
      width: width / 2,
      child: ElevatedButton(
        onPressed: () {
          taskVM.model.description.value = textEditingController.text;
          Get.back();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            colorList[taskVM.model.categoryModel.colorIndex],
          ),
        ),
        child: const Text(PersianStrings.add),
      ),
    ),
    title: 'افزودن یادداشت',
    middleText: '',
    titleStyle: const TextStyle(fontSize: 14),
    radius: AppDimens.radius,
  );
}
