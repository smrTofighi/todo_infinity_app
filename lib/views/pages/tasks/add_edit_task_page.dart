import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/models/task_model.dart';

// ignore: must_be_immutable
class AddEditTaskPage extends StatelessWidget {
  AddEditTaskPage({Key? key}) : super(key: key);
  var controller = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.backGround,
        appBar: AppBar(
          title: const Text(
            'یادداشت جدید',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
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
              TextField(
                maxLines: 3,
                controller: controller.taskEditingController,
                cursorColor: SolidColors.primary,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: SolidColors.backGround,
                  labelText: 'چه برنامه ای داری؟',
                  labelStyle: TextStyle(fontSize: 14),
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
                  const Text(
                    'افزودن هشدار',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
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
                  const Text(
                    'افزودن نکته',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
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
                  const Text(
                    'دسته بندی',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: Dimens.width,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              TaskModel task = TaskModel(
                  name: controller.taskEditingController.text,
                  note: 'note',
                  alarm: 'alarm',
                  category: 'category',
                  isComplete: false);
              controller.categoryModel.value.allTaskList!.add(task);
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
                    controller.categoryModel.value.color)),
            child: const Text('افزودن'),
          ),
        ),
      ),
    );
  }
}
