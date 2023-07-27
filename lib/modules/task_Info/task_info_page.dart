import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/button_style.dart';
import 'package:todo_infinity_app/core/styles/input_decoration.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';

import '../../../core/styles/text_styles.dart';
import '../category/category_controller.dart';
import '../task_list/task_list_controller.dart';

// ignore: must_be_immutable
class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var taskController = Get.find<TaskListController>();
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
          backgroundColor: LightColors.backGround,
          appBar: AppBar(
            title: Text(
                taskController.editTaskState.value
                    ? PersianStrings.editTask
                    : PersianStrings.newTask,
                style: LightTextStyles.titleOfAppBar),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.back();
                taskController.dateState.value = false;
                taskController.date.value = PersianStrings.addAlarm;
                taskController.editTaskState.value = false;
                taskController.time.value = PersianStrings.importance;
                taskController.timeState.value = false;
                taskController.taskEditingController.text = '';
              },
              color: Colors.black,
              icon: ImageIcon(
                MyIcons.arrowRight.image,
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
                    cursorColor:
                        colorList[taskController.categoryModel.value.color!],
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
                      MyIcons.clock.image,
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
                                  ? colorList[
                                      taskController.categoryModel.value.color!]
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
                      MyIcons.tags.image,
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
                            color: colorList[
                                taskController.categoryModel.value.color!],
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
  TaskListController taskController = Get.find<TaskListController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          MyIcons.notification.image,
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
                      ? colorList[taskController.categoryModel.value.color!]
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
  var taskController = Get.find<TaskListController>();
  var categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          taskController.checkInputsForTask(
              context, 'تمامی مقادیر باید پر باشند');
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              // Change your radius here
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            colorList[taskController.categoryModel.value.color!],
          ),
        ),
        child: Text(
          taskController.editTaskState.value
              ? PersianStrings.edit
              : PersianStrings.add,
        ),
      ),
    );
  }
}
