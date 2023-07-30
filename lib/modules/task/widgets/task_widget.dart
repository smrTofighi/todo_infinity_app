import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/box_decoration.dart';
import 'package:todo_infinity_app/data/models/task_model.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/dimens.dart';
import '../task_controller.dart';

class TaskAllWidget extends StatelessWidget {
  TaskAllWidget({super.key, required this.index});
  final int index;
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    List<TaskModel> taskList = taskController.categoryModel.value.todoListOn!;
    //? return widget
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          //? delete task slidable action
          SlidableAction(
            onPressed: (context) {
              taskController.isOnList.value = true;
              taskController.taskId.value = taskList[index].id!;
              taskController.taskIndex.value = index;
              taskController.deleteTask();
            },
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimens.radius),
              bottomRight: Radius.circular(Dimens.radius),
            ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),

          //? edit task slidable action
          SlidableAction(
            onPressed: (context) {},
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius),
              bottomLeft: Radius.circular(Dimens.radius),
            ),
            backgroundColor: LightColors.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {},
        onLongPress: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //? dueDate of task
              Center(
                child: Text(
                  taskList[index].dueDate!,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 0, 12, 0),
                margin:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                height: 45,
                width: MediaQuery.of(context).size.width / 1.55,
                decoration: AppBoxDecoration.taskWidgetDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //? subject of task
                    Text(
                      taskList[index].subject!,
                      style: const TextStyle(fontSize: 13),
                    ),
                    //? status of task
                    Obx(
                      () => Checkbox(
                        value: taskList[index].status! == '1' ? false : true,
                        onChanged: (value) {},
                        activeColor: colorList[
                            taskController.categoryModel.value.color!],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCompleteWidget extends StatelessWidget {
  TaskCompleteWidget({Key? key, required this.index}) : super(key: key);
  final TaskController taskController = Get.find<TaskController>();
  final int index;
  @override
  Widget build(BuildContext context) {
    List<TaskModel> taskList = taskController.categoryModel.value.todoListOff!;
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              taskController.isOnList.value = false;
              taskController.taskId.value = taskList[index].id!;
              taskController.taskIndex.value = index;
              taskController.deleteTask();
            },
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimens.radius),
              bottomRight: Radius.circular(Dimens.radius),
            ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: (context) {},
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius),
              bottomLeft: Radius.circular(Dimens.radius),
            ),
            backgroundColor: LightColors.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {},
        onLongPress: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  taskController
                      .categoryModel.value.todoListOff![index].dueDate!,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 0, 12, 0),
                margin:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                height: 45,
                width: MediaQuery.of(context).size.width / 1.55,
                decoration: AppBoxDecoration.taskWidgetDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //? subject task
                    Text(
                      taskController
                          .categoryModel.value.todoListOff![index].subject!,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),

                    //? status task
                    Obx(
                      () => Checkbox(
                        value: taskList[index].status == '2',
                        onChanged: (value) {},
                        activeColor: colorList[
                            taskController.categoryModel.value.color!],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
