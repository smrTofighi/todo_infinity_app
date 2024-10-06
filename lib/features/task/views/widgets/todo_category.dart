
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/extensions.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';

class TodoCategory extends StatelessWidget {
  const TodoCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskViewModel>(
      builder: (taskVM) {
        return GestureDetector(
          onTap:  (){},
          child: Row(
            children: [
              ImageIcon(
                taskVM.model.categoryModel.title.isEmpty
                    ? MyIcons.tags.image
                    : iconList[taskVM.model.categoryModel.iconIndex].image,
                size: 18,
                color: taskVM.model.categoryModel.title.isEmpty
                    ? Colors.grey
                    : colorList[taskVM.model.categoryModel.colorIndex],
              ),
              AppDimens.medium.width,
              Text(
                  taskVM.model.categoryModel.title.isEmpty
                      ? 'انتخاب دسته بندی'
                      : taskVM.model.categoryModel.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: taskVM.model.categoryModel.title.isEmpty
                        ? FontWeight.w300
                        : FontWeight.bold,
                    color: taskVM.model.categoryModel.title.isEmpty
                        ? Colors.grey
                        : colorList[taskVM.model.categoryModel.colorIndex],
                  ),
                ),
              
            ],
          ),
        );
      },
    );
  }
}
