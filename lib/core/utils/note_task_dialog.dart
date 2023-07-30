import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/modules/task/task_controller.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/strings.dart';

noteTaskDialog(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  TaskController controller = Get.find<TaskController>();
  Get.defaultDialog(
    barrierDismissible: false,
    backgroundColor: LightColors.card,
    buttonColor: LightColors.primary,
    content: TextField(
      controller: controller.noteTaskEditingController,
      decoration: InputDecoration(
        hintText: 'نکات خود را اینجا بنویسید ...',
        hintStyle: LightTextStyles.normall12(LightColors.greyText),
      ),
      style: LightTextStyles.normall12(LightColors.blackText),
    ),
    confirm: Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      height: 30,
      width: width / 2,
      child: ElevatedButton(
        onPressed: () {
          controller.note.value = controller.noteTaskEditingController.text;
          controller.noteState.value = true;
          Get.back();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              colorList[controller.categoryModel.value.color!]),
        ),
        child: const Text(PersianStrings.add),
      ),
    ),
    
    title: 'افزودن یادداشت',
    middleText: '',
    titleStyle: const TextStyle(fontSize: 14),
    radius: Dimens.radius,
  );
}
