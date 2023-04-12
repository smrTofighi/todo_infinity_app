import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../../controllers/task_controller.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/dimens.dart';
import '../../../../models/task_model.dart';

// ignore: must_be_immutable
class TaskAllWidget extends StatelessWidget {
  TaskAllWidget({super.key, required this.index});
  final int index;
  TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    String time = taskController.categoryModel.value.allTaskList![index].time!;
    String date = taskController.categoryModel.value.allTaskList![index].date!;
    String name = taskController.categoryModel.value.allTaskList![index].name!;
    bool value =
        taskController.categoryModel.value.allTaskList![index].isComplete!;
    //? return widget
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              taskController.deleteAllTask(index, context);
            },
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimens.radius),
              bottomRight: Radius.circular(Dimens.radius),
            ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            //label: 'حذف',
          ),
          SlidableAction(
            onPressed: (context) {
              List<TaskModel> list =
                  taskController.categoryModel.value.allTaskList!;
              taskController.goToEditAllTask(index, list);
            },
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius),
              bottomLeft: Radius.circular(Dimens.radius),
            ),
            backgroundColor: SolidColors.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            //label: 'انجام شد',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          List<TaskModel> list =
              taskController.categoryModel.value.allTaskList!;
          taskController.goToEditAllTask(index, list);
        },
        onLongPress: () {
          taskController.deleteAllTask(index, context);
        },
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
                        spreadRadius: 0.2)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 13),
                    ),
                    Obx(
                      () => Checkbox(
                        value: value,
                        onChanged: (value) {
                          if (taskController.categoryModel.value
                                  .allTaskList![index].isComplete ==
                              false) {
                            taskController.categoryModel.update((val) {
                              val!.allTaskList![index].isComplete = true;
                            });
                            taskController.categoryModel.value.completeTaskList!
                                .add(taskController
                                    .categoryModel.value.allTaskList![index]);
                            taskController.categoryModel.value.allTaskList!
                                .removeAt(index);
                          }
                        },
                        activeColor: taskController.categoryModel.value.color,
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

// ignore: must_be_immutable
class TaskCompleteWidget extends StatelessWidget {
  TaskCompleteWidget({Key? key, required this.index}) : super(key: key);
  TaskController taskController = Get.find<TaskController>();
  final int index;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              taskController.deleteCompleteTask(index, context);
            },
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimens.radius),
              bottomRight: Radius.circular(Dimens.radius),
            ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            //label: 'حذف',
          ),
          SlidableAction(
            onPressed: (context) {
              var list = taskController.categoryModel.value.completeTaskList!;
              taskController.goToEditCompleteTask(index, list);
            },
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius),
              bottomLeft: Radius.circular(Dimens.radius),
            ),
            backgroundColor: SolidColors.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            //label: 'انجام شد',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          var list = taskController.categoryModel.value.completeTaskList!;
          taskController.goToEditCompleteTask(index, list);
        },
        onLongPress: () {
          taskController.deleteCompleteTask(index, context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    taskController
                        .categoryModel.value.completeTaskList![index].time!,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    taskController
                        .categoryModel.value.completeTaskList![index].date!,
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
                        spreadRadius: 0.2)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      taskController
                          .categoryModel.value.completeTaskList![index].name!,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                    Obx(
                      () => Checkbox(
                        value: taskController.categoryModel.value
                            .completeTaskList![index].isComplete,
                        onChanged: (value) {
                          if (taskController.categoryModel.value
                                  .completeTaskList![index].isComplete ==
                              true) {
                            taskController.categoryModel.update((val) {
                              val!.completeTaskList![index].isComplete = false;
                            });
                            taskController.categoryModel.value.allTaskList!.add(
                                taskController.categoryModel.value
                                    .completeTaskList![index]);
                            taskController.categoryModel.value.completeTaskList!
                                .removeAt(index);
                          }
                        },
                        activeColor: taskController.categoryModel.value.color,
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
