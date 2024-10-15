
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/features/task/views/widgets/task_list_widget.dart';

import '../../../../core/values/colors.dart';
import '../../../../core/widgets/loading.dart';
import '../../view_model/task_view_model.dart';

class BottomSection extends StatelessWidget {
  BottomSection({
    super.key,
  });

  final TaskViewModel taskVM = Get.find<TaskViewModel>();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(34.0, 24, 34.0, 0),
        width: Get.width,
        height: Get.height / 1.55,

        //TODO use double
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).cardColor,
        ),
        child: SingleChildScrollView(
          child: Obx(
                  () => taskVM.isLoading.value
                  ? Center(
                child: Loading(
                  color: colorList[taskVM.model.categoryModel.colorIndex],
                  size: 36,
                ),
              )
                  : GetBuilder<TaskViewModel>(builder: (taskVM) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TodoListWidget(
                      topTitle: 'ماموریت های فعال',
                      todoList: taskVM.model.categoryModel.activeTodos!,

                    ),
                    const Divider(),
                    TodoListWidget(
                      topTitle: 'ماموریت های انجام شده',
                      todoList: taskVM.model.categoryModel.unActiveTodos!,
                    ),
                  ],
                );
              })
          ),
        ),
      ),
    );
  }
}
