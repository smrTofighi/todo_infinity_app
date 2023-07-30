import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_infinity_app/core/utils/api_constant.dart';
import 'package:todo_infinity_app/core/utils/api_key.dart';
import 'package:todo_infinity_app/core/utils/loading_dialog.dart';
import 'package:todo_infinity_app/data/services/dio_service.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/strings.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/task_model.dart';
import '../../../routes/pages.dart';

class TaskController extends GetxController {
  //? A model of the category that will be quantified
  Rx<CategoryModel> categoryModel = CategoryModel().obs;

  TextEditingController taskEditingController = TextEditingController();
  //? A TextEditingController is for task title
  TextEditingController noteTaskEditingController = TextEditingController();
  RxInt categoryId = RxInt(0);

  RxInt categoryIndex = RxInt(0);
  RxInt importanceIndex = RxInt(0);
  RxInt taskIndex = 0.obs;
  RxInt taskId = RxInt(0);
  RxString category = 'دسته بندی'.obs;
  RxString alarm = 'افزودن هشدار'.obs;
  RxString note = 'افزودن یادداشت'.obs;
  RxBool alarmState = false.obs;
  RxBool noteState = false.obs;
  RxBool editTaskState = false.obs;
  RxBool taskCompleteState = false.obs;
  RxBool isOnList = false.obs;

  addTask() async {
    String url = ApiConstant.todoAddApi(taskEditingController.text, noteTaskEditingController.text,
        '1', categoryId.value.toString(), alarm.value, '1');

    var response = await DioService().postMethod(url);
    if (response.data[ApiKey.success] == true) {
      var id = response.data[ApiKey.data]['id'];
      TaskModel model = TaskModel(
          id: id,
          subject: taskEditingController.text,
          category: categoryId.value,
          dueDate: alarm.value,
          status: '1');
      categoryModel.value.todoListOn!.add(model);
      getTaskList();
      Get.offNamed(PageName.taskListPage);
    }
  }

  getTaskList() async {
    String url = ApiConstant.categoriShowApi(categoryId.toString());
    var response = await DioService().getMethod(url);
    if (response.data[ApiKey.success] == true) {
      response.data[ApiKey.data].forEach((task) {
        if (task[ApiKey.status] == '1') {
          categoryModel.value.todoListOn!.add(TaskModel.fromJson(task));
        } else {
          categoryModel.value.todoListOff!.add(TaskModel.fromJson(task));
        }
      });
      Get.toNamed(PageName.taskListPage);
    }
  }

  deleteTask() async {
    loadingDialog();
    String url = ApiConstant.todoDeleteApi(taskId.value.toString());
    var response = await DioService().deleteMethod(url);
    if (response.data[ApiKey.success] == true) {
      categoryModel.update((val) {
        if (isOnList.value) {
          val!.todoListOn!.removeAt(taskIndex.value);
        } else {
          val!.todoListOff!.removeAt(taskIndex.value);
        }
      });
    }
    Get.back();
  }

  toastMessage(String message, BuildContext context) {
    toastification.showSuccess(
      context: context,
      title: message,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  deleteTasks(BuildContext context) {
    toastMessage('موفقیت آمیز بود', context);

    Get.offAllNamed(PageName.categoryPage);
  }

  deleteAllTask(int index, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: LightColors.card,
      confirm: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        height: 30,
        width: width / 4,
        child: ElevatedButton(
          onPressed: () {
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
      middleText: 'ماموریت حذف شود؟',
      radius: Dimens.radius,
    );
  }

  deleteCompleteTask(int index, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: LightColors.card,
      confirm: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        height: 30,
        width: width / 4,
        child: ElevatedButton(
          onPressed: () {
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
      middleText: 'ماموریت حذف شود؟',
      radius: Dimens.radius,
    );
  }

  addAlarm(BuildContext context) async {
    String selectedDate = Jalali.now().toJalaliDateTime();
    Jalali? datePicked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1400, 8),
      lastDate: Jalali(1450, 9),
    );
    // var picked = await showTimePicker(
    //   context: context,
    //   initialTime: TimeOfDay.now(),
    // );

    if (datePicked != null && datePicked.toString() != selectedDate) {
      alarm.value = datePicked.formatCompactDate();
      alarmState.value = true;
    }
    // if (picked != null) {
    //   alarm.value =
    //       '${alarm.value} \n ${picked.hour.toString()}:${picked.minute.toString()}';
    //   timeState.value = true;
    // }
  }

  editAllTask() {
    categoryModel.update((val) {});
    Get.offNamed(PageName.taskListPage);
  }

  editCompleteTask() {
    categoryModel.update((val) {});
    Get.offAllNamed(PageName.categoryPage);
  }

  //? clear all inputs in add edit task page
  clearInputs() {
    alarm.value = PersianStrings.addAlarm;
    editTaskState.value = false;
    alarmState.value = false;
    taskEditingController.text = '';
  }

  //? go to edit task page for all task
  goToEditAllTask(int index, List<TaskModel> list) {
    taskIndex.value = index;
    taskCompleteState.value = false;
    editTaskState.value = true;
    alarmState.value = true;
    alarm.value = list[index].dueDate!;
    taskEditingController.text = list[index].subject!;
    Get.toNamed(PageName.taskInfoPage);
  }

  //? go to edit task page for complete task
  goToEditCompleteTask(int index, List<TaskModel> list) {
    taskIndex.value = index;
    taskCompleteState.value = true;
    editTaskState.value = true;
    alarmState.value = true;
    alarm.value = list[index].dueDate!;
    taskEditingController.text = list[index].subject!;
    Get.toNamed(PageName.taskInfoPage);
  }
}
