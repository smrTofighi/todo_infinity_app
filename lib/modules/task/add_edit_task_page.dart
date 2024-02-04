import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/button_style.dart';
import 'package:todo_infinity_app/core/styles/input_decoration.dart';
import 'package:todo_infinity_app/core/utils/note_task_dialog.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/core/styles/extensions.dart';
import '../../../core/styles/text_styles.dart';
import '../category/category_controller.dart';
import 'task_controller.dart';

class AddEditTaskPage extends StatefulWidget {
  const AddEditTaskPage({Key? key}) : super(key: key);

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final TaskController taskController = Get.find<TaskController>();
  final CategoryController categoryController = Get.find<CategoryController>();

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
                taskController.alarm.value = PersianStrings.addAlarm;
                taskController.editTaskState.value = false;
                taskController.alarmState.value = false;
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
                (Dimens.high * 2).height,
                TextField(
                    maxLines: 3,
                    controller: taskController.taskEditingController,
                    cursorColor:
                        colorList[taskController.categoryModel.value.color!],
                    decoration: MyInputDecoration.textFieldAddEditTaskPage),
                const Divider(),
                (Dimens.medium * 2).height,
                TaskAlarm(),
                (Dimens.medium * 2).height,
                TaskNote(),
                (Dimens.medium * 2).height,
                TaskCategory(),
              ],
            ),
          ),
          bottomNavigationBar: AddEditTaskBottomNavigation(),
        ),
      ),
    );
  }
}

class TaskCategory extends StatelessWidget {
  TaskCategory({
    super.key,
  });

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          MyIcons.tags.image,
          size: 18,
          color: Colors.grey,
        ),
        Dimens.medium.width,
        TextButton(
          onPressed: () {},
          style: MyButtonStyle.textButtonAddEditTaskPage,
          child: Text(
            taskController.categoryModel.value.title!,
            style: TextStyle(
              color: colorList[taskController.categoryModel.value.color!],
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class TaskAlarm extends StatelessWidget {
  TaskAlarm({
    super.key,
  });
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          MyIcons.notification.image,
          size: 18,
          color: Colors.grey,
        ),
        Dimens.medium.width,
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

class TaskNote extends StatelessWidget {
  TaskNote({
    super.key,
  });
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          MyIcons.note.image,
          size: 18,
          color: Colors.grey,
        ),
        Dimens.medium.width,
        TextButton(
          onPressed: () {
            noteTaskDialog(context);
          },
          style: MyButtonStyle.textButtonAddEditTaskPage,
          child: Obx(
            () => Text(
              taskController.note.value,
              style: TextStyle(
                color: taskController.noteState.value
                    ? colorList[taskController.categoryModel.value.color!]
                    : Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddEditTaskBottomNavigation extends StatelessWidget {
  AddEditTaskBottomNavigation({
    super.key,
  });
  final TaskController taskController = Get.find<TaskController>();
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          //taskController.addTask();
          Get.back();
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
