import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/routes/pages.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';
import 'package:todo_infinity_app/features/task/views/widgets/top_section.dart';
import '../../../main/widgets/floating_action_button.dart';
import '../widgets/bottom_sheet.dart';

class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});

  final TaskViewModel taskVM = Get.find<TaskViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorList[taskVM.model.categoryModel.colorIndex],
        body: Stack(
          children: [
            TopSection(),
            BottomSection(),
          ],
        ),
        floatingActionButton: Obx(
          () =>  MyFloatingActionButton(
            onPressed: () {
              taskVM.isEditing(false);
              Get.toNamed(PageName.taskSingle);
            },
            icon: FontAwesomeIcons.plus,
            isLoading: taskVM.isLoadingUpdate.value,
            color: colorList[taskVM.model.categoryModel.colorIndex],
          ),
        ),
      ),
    );
  }
}
