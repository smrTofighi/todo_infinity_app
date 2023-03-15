import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/styles/button_style.dart';
import 'package:todo_infinity_app/core/styles/input_decoration.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/models/task_model.dart';
import 'package:todo_infinity_app/routes/pages.dart';

// ignore: must_be_immutable
class AddEditTaskPage extends StatefulWidget {
  const AddEditTaskPage({Key? key}) : super(key: key);

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  var taskController = Get.find<TaskController>();
  var categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          taskController.alarmState.value = false;
          taskController.alarm.value = MyStrings.addAlarm;
          taskController.editTaskState.value = false;
          taskController.importance.value = MyStrings.importance;
          taskController.importanceState.value = false;
          taskController.taskEditingController.text = '';

          return true;
        },
        child: Scaffold(
          backgroundColor: SolidColors.backGround,
          appBar: AppBar(
            title: Text(
              taskController.editTaskState.value
                  ? MyStrings.editTask
                  : MyStrings.newTask,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.back();
                taskController.alarmState.value = false;
                taskController.alarm.value = MyStrings.addAlarm;
                taskController.editTaskState.value = false;
                taskController.importance.value = MyStrings.importance;
                taskController.importanceState.value = false;
                taskController.taskEditingController.text = '';
              },
              color: Colors.black,
              icon: ImageIcon(
                MyIcons.arrowRight,
                size: 22,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Column(
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                TextField(
                    maxLines: 3,
                    controller: taskController.taskEditingController,
                    cursorColor: taskController.categoryModel.value.color,
                    decoration: MyInputDecoration.textFieldAddEditTaskPage),
                const Divider(),
                const SizedBox(
                  height: 24,
                ),
                TaskAlarm(),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  children: [
                    ImageIcon(
                      MyIcons.note,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        taskController.addNote();
                      },
                      style: MyButtonStyle.textButtonAddEditTaskPage,
                      child: Obx(
                        () => Text(
                          taskController.importance.value,
                          style: TextStyle(
                              color: taskController.importanceState.value
                                  ? taskController.categoryModel.value.color
                                  : Colors.grey,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  children: [
                    ImageIcon(
                      MyIcons.tags,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: MyButtonStyle.textButtonAddEditTaskPage,
                      child: Text(
                        taskController.categoryModel.value.name!,
                        style: TextStyle(
                            color: taskController.categoryModel.value.color,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: AddEditTaskBottomNavigation(),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskAlarm extends StatelessWidget {
  TaskAlarm({
    super.key,
  });
  TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          MyIcons.notification,
          size: 18,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 16,
        ),
        TextButton(
          onPressed: () {
            taskController.addAlarm(context);
          },
          style: MyButtonStyle.textButtonAddEditTaskPage,
          child: Obx(
            () => Text(
              taskController.alarm.value,
              style: TextStyle(
                  color: taskController.alarmState.value
                      ? taskController.categoryModel.value.color
                      : Colors.grey,
                  fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class AddEditTaskBottomNavigation extends StatelessWidget {
  AddEditTaskBottomNavigation({
    super.key,
  });
  var taskController = Get.find<TaskController>();
  var categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.width,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          taskController.editTaskState.value
              ? taskController.taskCompleteState.value
                  ? taskController.editCompleteTask()
                  : taskController.editAllTask()
              : taskController.addTask();
          categoryController.countAllItemsCategories();
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              // Change your radius here
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            taskController.categoryModel.value.color,
          ),
        ),
        child: Text(
          taskController.editTaskState.value ? MyStrings.edit : MyStrings.add,
        ),
      ),
    );
  }
}
