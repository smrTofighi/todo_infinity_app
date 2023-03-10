import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/models/category_model.dart';

import '../core/values/dimens.dart';
import '../core/values/strings.dart';

class TaskController extends GetxController {
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  //? A model of the category that will be quantified
  TextEditingController taskEditingController = TextEditingController();
  //? A TextEditingController is for task title
  RxInt categoryIndex = RxInt(0);
  RxInt importanceIndex = RxInt(0);
  RxString category = 'دسته بندی'.obs;
  RxString alarm = 'افزودن هشدار'.obs;
  RxString importance = 'میزان اهمیت'.obs;
  RxBool importanceState = false.obs;
  addNote() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: MyStrings.importance,
      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      content: SizedBox(
          width: Dimens.width,
          child: Column(
            children: [
              Obx(
                () => RadioListTile(
                  title: const Text("کم"),
                  value: "کم",
                  groupValue: importance.value,
                  onChanged: (value) {
                    importance.value = value.toString();
                  },
                ),
              ),
              Obx(
                () => RadioListTile(
                  title: const Text("متوسط"),
                  value: "متوسط",
                  groupValue: importance.value,
                  onChanged: (value) {
                    importance.value = value.toString();
                  },
                ),
              ),
              Obx(
                () => RadioListTile(
                  title: const Text("زیاد"),
                  value: "زیاد",
                  groupValue: importance.value,
                  onChanged: (value) {
                    importance.value = value.toString();
                  },
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 35,
                    width: Dimens.width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('تایید'),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: Dimens.width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        importance.value = MyStrings.importance;
                        Get.back();
                      },
                      child: const Text('لغو'),
                    ),
                  ),
                ],
              )
            ],
          )),
      radius: 6,
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(8.0),
    );
  }

  addAlarm() {}
  editCategory() {}
  addTask() {}
}
