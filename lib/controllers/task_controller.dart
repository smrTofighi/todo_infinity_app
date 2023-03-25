import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_infinity_app/models/category_model.dart';

import '../core/values/dimens.dart';
import '../core/values/strings.dart';
import '../models/task_model.dart';
import '../routes/pages.dart';

class TaskController extends GetxController {
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  //? A model of the category that will be quantified
  TextEditingController taskEditingController = TextEditingController();
  //? A TextEditingController is for task title
  RxInt categoryIndex = RxInt(0);
  RxInt importanceIndex = RxInt(0);
  RxInt taskIndex = 0.obs;
  RxString category = 'دسته بندی'.obs;
  RxString alarm = 'افزودن هشدار'.obs;
  RxString importance = 'میزان اهمیت'.obs;
  RxBool importanceState = false.obs;
  RxBool alarmState = false.obs;
  RxBool editTaskState = false.obs;
  RxBool taskCompleteState = false.obs;

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
                  activeColor: categoryModel.value.color),
            ),
            Obx(
              () => RadioListTile(
                  title: const Text("متوسط"),
                  value: "متوسط",
                  groupValue: importance.value,
                  onChanged: (value) {
                    importance.value = value.toString();
                  },
                  activeColor: categoryModel.value.color),
            ),
            Obx(
              () => RadioListTile(
                  title: const Text("زیاد"),
                  value: "زیاد",
                  groupValue: importance.value,
                  onChanged: (value) {
                    importance.value = value.toString();
                  },
                  activeColor: categoryModel.value.color),
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
                      importanceState.value = true;
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            categoryModel.value.color)),
                    child: const Text('تایید'),
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: Dimens.width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      // importance.value = MyStrings.importance;
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            categoryModel.value.color)),
                    child: const Text('لغو'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      radius: 6,
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(8.0),
    );
  }

  addAlarm(BuildContext context) async {
    String selectedDate = Jalali.now().toJalaliDateTime();
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1400, 8),
      lastDate: Jalali(1450, 9),
    );

    if (picked != null && picked.toString() != selectedDate) {
      alarm.value = picked.formatFullDate();
      alarmState.value = true;
    }
  }

  editCategory() {}
  addTask() {
    TaskModel task = TaskModel(
      name: taskEditingController.text,
      importance: importance.value,
      alarm: alarm.value,
      category: category.value,
      isComplete: false,
    );

    categoryModel.value.allTaskList!.add(task);

    Get.offNamed(PageName.taskListPage);
  }

  editAllTask() {
    categoryModel.update((val) {
      val!.allTaskList![taskIndex.value].name = taskEditingController.text;
      val.allTaskList![taskIndex.value].alarm = alarm.value;
      val.allTaskList![taskIndex.value].importance = importance.value;
    });
    Get.offNamed(PageName.taskListPage);
  }

  editCompleteTask() {
    categoryModel.update((val) {
      val!.completeTaskList![taskIndex.value].name = taskEditingController.text;
      val.completeTaskList![taskIndex.value].alarm = alarm.value;
      val.completeTaskList![taskIndex.value].importance = importance.value;
    });
    Get.offAllNamed(PageName.categoryPage);
  }

  clearInputs() {
    alarmState.value = false;
    alarm.value = MyStrings.addAlarm;
    editTaskState.value = false;
    importance.value = MyStrings.importance;
    importanceState.value = false;
    taskEditingController.text = '';
  }

  goToEditAllTask(int index, List<TaskModel> list) {
    taskIndex.value = index;
    taskCompleteState.value = false;
    editTaskState.value = true;
    importanceState.value = true;
    alarmState.value = true;
    alarm.value = list[index].alarm!;
    importance.value = list[index].importance!;
    taskEditingController.text = list[index].name!;
    Get.toNamed(PageName.addEditTaskPage);
  }

  goToEditCompleteTask(int index, List<TaskModel> list) {
    taskIndex.value = index;
    taskCompleteState.value = true;
    editTaskState.value = true;
    importanceState.value = true;
    alarmState.value = true;
    alarm.value = list[index].alarm!;
    importance.value = list[index].importance!;
    taskEditingController.text = list[index].name!;
    Get.toNamed(PageName.addEditTaskPage);
  }
}
