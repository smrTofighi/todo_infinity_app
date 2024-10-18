import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/features/main/main_category/view_model/main_category_view_model.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';

class TaskListAppBar extends StatelessWidget {
  const TaskListAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.find<MainCategoryViewModel>().getCategories();
              //Get.find<TaskViewModel>().clearTodos();
              Get.delete<TaskViewModel>();
              Get.back();
            },
            icon: ImageIcon(
              MyIcons.arrowRight.image,
              color: Colors.white,
            ),
          ),
          //DropdownTaskList()
        ],
      ),
    );
  }
}
