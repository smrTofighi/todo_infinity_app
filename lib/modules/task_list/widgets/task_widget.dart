import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/dimens.dart';
import '../task_list_controller.dart';

// ignore: must_be_immutable
class TaskAllWidget extends StatelessWidget {
  TaskAllWidget({super.key, required this.index});
  final int index;
  TaskListController taskController = Get.find<TaskListController>();

  @override
  Widget build(BuildContext context) {
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
            onPressed: (context) {},
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
        onTap: () {},
        onLongPress: () {
          taskController.deleteAllTask(index, context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'time',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'date',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
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
                    const Text(
                      'name',
                      style: TextStyle(fontSize: 13),
                    ),
                    Obx(
                      () => Checkbox(
                        value: true,
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

// ignore: must_be_immutable
class TaskCompleteWidget extends StatelessWidget {
  TaskCompleteWidget({Key? key, required this.index}) : super(key: key);
  TaskListController taskController = Get.find<TaskListController>();
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
              taskController.goToEditCompleteTask(index, []);
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
          taskController.goToEditCompleteTask(index, []);
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
                        .categoryModel.value.todoListOff![index].time!,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    taskController
                        .categoryModel.value.todoListOff![index].date!,
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
                          .categoryModel.value.todoListOff![index].subject!,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                    Obx(
                      () => Checkbox(
                        value: true,
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
