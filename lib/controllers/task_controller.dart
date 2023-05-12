import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';
import 'package:todo_infinity_app/models/category_model.dart';
import '../core/values/colors.dart';
import '../core/values/dimens.dart';
import '../core/values/strings.dart';
import '../models/task_model.dart';
import '../routes/pages.dart';

class TaskController extends GetxController {
  List<Color> colorList = [
    SolidColors.primary,
    Colors.red,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.purple,
    Colors.amber,
    Colors.cyan,
    Colors.lime,
    Colors.pink,
    Colors.teal,
    Colors.blueGrey,
    Colors.indigo,
    Colors.lightGreen
  ];
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  //? A model of the category that will be quantified
  TextEditingController taskEditingController = TextEditingController();
  //? A TextEditingController is for task title
  RxInt categoryIndex = RxInt(0);
  RxInt importanceIndex = RxInt(0);
  RxInt taskIndex = 0.obs;
  RxString category = 'دسته بندی'.obs;
  RxString date = 'افزودن تاریخ'.obs;
  RxString time = 'افزودن ساعت'.obs;
  RxBool timeState = false.obs;
  RxBool dateState = false.obs;
  RxBool editTaskState = false.obs;
  RxBool taskCompleteState = false.obs;

  toastMessage(String message, BuildContext context) {
    toastification.showSuccess(
      context: context,
      title: message,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  deleteTasks(BuildContext context) {
    CategoryController categoryController = Get.find<CategoryController>();
    if (categoryModel.value.allTaskList!.isNotEmpty &
        categoryModel.value.completeTaskList!.isNotEmpty) {
      categoryModel.value.allTaskList!.clear();
      categoryModel.value.completeTaskList!.clear();
    } else if (categoryModel.value.allTaskList!.isNotEmpty) {
      categoryModel.value.allTaskList!.clear();
    } else if (categoryModel.value.completeTaskList!.isNotEmpty) {
      categoryModel.value.completeTaskList!.clear();
    }
    toastMessage('موفقیت آمیز بود', context);

    categoryController.countAllItemsCategories();
    Get.offAllNamed(PageName.categoryPage);
  }

  deleteAllTask(int index, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: SolidColors.card,
      confirm: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        height: 30,
        width: width / 4,
        child: ElevatedButton(
          onPressed: () {
            categoryModel.update((val) {
              val!.allTaskList!.removeAt(index);
            });
            Get.back();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.redAccent),
          ),
          child: const Text('حذف'),
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
          child: const Text('لغو'),
        ),
      ),
      title: '',
      titlePadding: const EdgeInsets.all(0),
      middleText:
          'ماموریت ${categoryModel.value.allTaskList![index].name} حذف شود؟',
      radius: Dimens.radius,
    );
  }

  deleteCompleteTask(int index, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: SolidColors.card,
      confirm: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        height: 30,
        width: width / 4,
        child: ElevatedButton(
          onPressed: () {
            categoryModel.update((val) {
              val!.completeTaskList!.removeAt(index);
            });
            Get.back();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.redAccent),
          ),
          child: const Text('حذف'),
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
          child: const Text('لغو'),
        ),
      ),
      title: '',
      titlePadding: const EdgeInsets.all(0),
      middleText:
          'ماموریت ${categoryModel.value.completeTaskList![index].name} حذف شود؟',
      radius: Dimens.radius,
    );
  }

  addTime(BuildContext context) async {
    //var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    // Get.defaultDialog(
    //   barrierDismissible: false,
    //   title: MyStrings.importance,
    //   titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //   content: Column(
    //     children: [
    //       Obx(
    //         () => RadioListTile(
    //             title: const Text("کم"),
    //             value: "کم",
    //             groupValue: time.value,
    //             onChanged: (value) {
    //               time.value = value.toString();
    //             },
    //             activeColor: categoryModel.value.color),
    //       ),
    //       Obx(
    //         () => RadioListTile(
    //             title: const Text("متوسط"),
    //             value: "متوسط",
    //             groupValue: time.value,
    //             onChanged: (value) {
    //               time.value = value.toString();
    //             },
    //             activeColor: categoryModel.value.color),
    //       ),
    //       Obx(
    //         () => RadioListTile(
    //             title: const Text("زیاد"),
    //             value: "زیاد",
    //             groupValue: time.value,
    //             onChanged: (value) {
    //               time.value = value.toString();
    //             },
    //             activeColor: categoryModel.value.color),
    //       ),
    //       const SizedBox(
    //         height: 25.0,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           SizedBox(
    //             height: 35,
    //             width: width / 3.3,
    //             child: ElevatedButton(
    //               onPressed: () {
    //                 timeState.value = true;
    //                 Get.back();
    //               },
    //               style: ButtonStyle(
    //                   backgroundColor:
    //                       MaterialStateProperty.all(categoryModel.value.color)),
    //               child: const Text('تایید'),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 35,
    //             width: width / 3.3,
    //             child: ElevatedButton(
    //               onPressed: () {
    //                 // importance.value = MyStrings.importance;
    //                 Get.back();
    //               },
    //               style: ButtonStyle(
    //                   backgroundColor:
    //                       MaterialStateProperty.all(categoryModel.value.color)),
    //               child: const Text('لغو'),
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    //   radius: 6,
    //   backgroundColor: Colors.white,
    //   contentPadding: const EdgeInsets.all(8.0),
    // );

    var picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      time.value = '${picked.hour.toString()}:${picked.minute.toString()}';
      timeState.value = true;
    }
  }

  addDate(BuildContext context) async {
    String selectedDate = Jalali.now().toJalaliDateTime();
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1400, 8),
      lastDate: Jalali(1450, 9),
    );

    if (picked != null && picked.toString() != selectedDate) {
      date.value = picked.formatCompactDate();
      dateState.value = true;
    }
  }

  checkInputsForTask(BuildContext context, String title) {
    if (!dateState.value |
        !timeState.value |
        (taskEditingController.text == '')) {
      toastification.showError(
        context: context,
        title: title,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else {
      editTaskState.value
          ? taskCompleteState.value
              ? editCompleteTask()
              : editAllTask()
          : addTask();
      clearInputs();
    }
  }

  void addTask() {
    TaskModel task = TaskModel(
      name: taskEditingController.text,
      time: time.value,
      date: date.value,
      category: category.value,
      isComplete: false,
    );
    categoryModel.value.allTaskList!.add(task);
 
    Get.offNamed(PageName.taskListPage);
  }

  editAllTask() {
    categoryModel.update((val) {
      val!.allTaskList![taskIndex.value].name = taskEditingController.text;
      val.allTaskList![taskIndex.value].date = date.value;
      val.allTaskList![taskIndex.value].time = time.value;
    });
    Get.offNamed(PageName.taskListPage);
  }

  editCompleteTask() {
    categoryModel.update((val) {
      val!.completeTaskList![taskIndex.value].name = taskEditingController.text;
      val.completeTaskList![taskIndex.value].date = date.value;
      val.completeTaskList![taskIndex.value].time = time.value;
    });
    Get.offAllNamed(PageName.categoryPage);
  }

  //? clear all inputs in add edit task page
  clearInputs() {
    dateState.value = false;
    date.value = MyStrings.addAlarm;
    editTaskState.value = false;
    time.value = MyStrings.importance;
    timeState.value = false;
    taskEditingController.text = '';
  }

  //? go to edit task page for all task
  goToEditAllTask(int index, List<TaskModel> list) {
    taskIndex.value = index;
    taskCompleteState.value = false;
    editTaskState.value = true;
    timeState.value = true;
    dateState.value = true;
    date.value = list[index].date!;
    time.value = list[index].time!;
    taskEditingController.text = list[index].name!;
    Get.toNamed(PageName.addEditTaskPage);
  }

  //? go to edit task page for complete task
  goToEditCompleteTask(int index, List<TaskModel> list) {
    taskIndex.value = index;
    taskCompleteState.value = true;
    editTaskState.value = true;
    timeState.value = true;
    dateState.value = true;
    date.value = list[index].date!;
    time.value = list[index].time!;
    taskEditingController.text = list[index].name!;
    Get.toNamed(PageName.addEditTaskPage);
  }
}
