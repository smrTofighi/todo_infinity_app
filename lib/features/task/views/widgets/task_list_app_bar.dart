import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/routes/pages.dart';
import 'package:todo_infinity_app/core/values/icons.dart';

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
