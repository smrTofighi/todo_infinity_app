import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/styles/button_style.dart';
import 'package:todo_infinity_app/core/styles/input_decoration.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';

import '../../../core/styles/text_styles.dart';

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
          taskController.clearInputs();
          return true;
        },
        child: Scaffold(
          backgroundColor: SolidColors.backGround,
          appBar: AppBar(
            title: Text(
                taskController.editTaskState.value
                    ? MyStrings.editTask
                    : MyStrings.newTask,
                style: MyTextStyles.titleOfAppBar),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.back();
                taskController.dateState.value = false;
                taskController.date.value = MyStrings.addAlarm;
                taskController.editTaskState.value = false;
                taskController.time.value = MyStrings.importance;
                taskController.timeState.value = false;
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
                      MyIcons.clock,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        taskController.addTime(context);
                      },
                      style: MyButtonStyle.textButtonAddEditTaskPage,
                      child: Obx(
                        () => Text(
                          taskController.time.value,
                          style: TextStyle(
                              color: taskController.timeState.value
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
            taskController.addDate(context);
          },
          style: MyButtonStyle.textButtonAddEditTaskPage,
          child: Obx(
            () => Text(
              taskController.date.value,
              style: TextStyle(
                  color: taskController.dateState.value
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
          taskController.checkInputsForTask(
              context, 'تمامی مقادیر باید پر باشند');
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
