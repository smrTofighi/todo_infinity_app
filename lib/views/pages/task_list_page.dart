import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/views/widgets/floating_action_button.dart';

// ignore: must_be_immutable
class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});
  var taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: taskController.categoryModel.value.color,
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 46),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: ImageIcon(
                          MyIcons.arrowRight,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          MyIcons.menuVertical,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 40, 24),
                  child: SizedBox(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: SolidColors.card,
                          ),
                          child: ImageIcon(
                            taskController.categoryModel.value.icon,
                            color: taskController.categoryModel.value.color,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          taskController.categoryModel.value.name!,
                          style: MyTextStyles.bigTextWhite,
                        ),
                        Text(
                          '${taskController.categoryModel.value.taskList!.length} یادداشت',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                height: Get.height / 1.55,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: SolidColors.card),
              ),
            )
          ],
        ),
        floatingActionButton: MyFloatingActionButton(
          onPressed: () {},
          color: taskController.categoryModel.value.color!,
        ),
      ),
    );
  }
}
