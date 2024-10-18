import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';
import 'package:todo_infinity_app/features/task/views/widgets/task_list_app_bar.dart';

class TopSection extends StatelessWidget {
  TopSection({
    super.key,
  });
  final TaskViewModel taskListWM = Get.find<TaskViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TaskListAppBar(),
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
                    color: AppColors.card,
                  ),
                  child: Hero(
                    tag: 'tag ${taskListWM.model.categoryModel.title}',
                    child: ImageIcon(
                      iconList[taskListWM.model.categoryModel.iconIndex].image,
                      color:
                          colorList[taskListWM.model.categoryModel.colorIndex],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  taskListWM.model.categoryModel.title,
                  style: AppTextStyles.bigTextWhite,
                ),
                GetBuilder<TaskViewModel>(
                 
                  builder: (vm) {
                    return Text(
                      '${vm.model.categoryModel.activeTodos?.length ?? 0} ماموریت',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
