import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/widgets/task_single/task_widget.dart';
import 'package:todo_infinity_app/data/models/todo_model.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';
import 'package:todo_infinity_app/features/task/views/widgets/no_todo_here.dart';

class TodoListWidget extends StatelessWidget {
  TodoListWidget({
    super.key,
    required this.topTitle,
    required this.todoList,
  });

  final TaskViewModel taskVM = Get.find<TaskViewModel>();
  final String topTitle;
  final RxList<TodoModel> todoList;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpandablePanel(
        header: Text(
          topTitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        collapsed: const SizedBox(),
        expanded: todoList.isEmpty
            ? const NoTodoHere()
            : SizedBox(
                width: AppDimens.infinity,
                height: todoList.length * 75,
                child: Obx(
                  () => ListView.builder(
                    itemCount: todoList.length,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TodoItemWidget(
                       todo: todoList[index],
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
              ),
      ),
    );
  }
}
