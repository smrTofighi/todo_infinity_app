import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
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
      child: Scaffold(
        backgroundColor: SolidColors.backGround,
        appBar: AppBar(
          title: const Text(
            'یادداشت جدید',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: SolidColors.backGround,
                  labelText: 'چه برنامه ای داری؟',
                  floatingLabelStyle: TextStyle(
                      color: taskController.categoryModel.value.color),
                  labelStyle: const TextStyle(fontSize: 14),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 24,
              ),
              Row(
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
                    onPressed: () {},
                    child: Text(
                      taskController.alarm.value,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
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
                    style: ButtonStyle(
                      alignment: Alignment.centerRight
                    ),
                    child: Obx(
                      () => Text(
                        taskController.importance.value,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 13),
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
        bottomNavigationBar: AddEditTaskBottomNavigation(
          taskController: taskController,
          categoryController: categoryController,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddEditTaskBottomNavigation extends StatelessWidget {
  const AddEditTaskBottomNavigation({
    super.key,
    required this.taskController,
    required this.categoryController,
  });
  final TaskController taskController;
  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.width,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          onTapAdd();
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                // Change your radius here
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
                taskController.categoryModel.value.color)),
        child: const Text('افزودن'),
      ),
    );
  }

  onTapAdd() {
    var note = taskController.importance.value == 'میزان اهمیت'
        ? ''
        : taskController.importance.value;
    TaskModel task = TaskModel(
      name: taskController.taskEditingController.text,
      note: note,
      alarm: taskController.alarm.value,
      category: taskController.category.value,
      isComplete: false,
    );
    // var mainCategory = categoryController.categoryList[0];
    // int index = taskController.categoryIndex.value;

    taskController.categoryModel.value.allTaskList!.add(task);
    categoryController.countAllItemsCategories();
    Get.offAllNamed(PageName.categoryPage);
  }
}
