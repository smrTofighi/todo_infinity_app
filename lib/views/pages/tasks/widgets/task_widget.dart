import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/category_controller.dart';
import '../../../../controllers/task_controller.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/dimens.dart';

// ignore: must_be_immutable
class TaskWidget extends StatelessWidget {
  TaskWidget(
      {super.key,
      required this.onTap,
      required this.onLongPress,
      required this.name,
      required this.time,
      required this.date,
      required this.value,
      required this.onChanged});
  final String name;
  final String time;
  final String date;
  final bool value;
  final Function() onChanged;
  final Function() onTap;
  final Function() onLongPress;

  TaskController taskController = Get.find<TaskController>();
  CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4, 0, 12, 0),
              margin:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
              height: 45,
              width: MediaQuery.of(context).size.width / 1.55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.radius),
                color: SolidColors.card,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 0.2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                  Obx(
                    () => Checkbox(
                      value: value,
                      onChanged: onChanged(),
                      activeColor: taskController.categoryModel.value.color,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
