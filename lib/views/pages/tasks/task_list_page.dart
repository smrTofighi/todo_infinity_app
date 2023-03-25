import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/models/task_model.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/pages/tasks/widgets/dropdown_task_list_widget.dart';
import 'package:todo_infinity_app/views/widgets/floating_action_button.dart';
import '../../../controllers/category_controller.dart';
import '../../../core/values/strings.dart';

// ignore: must_be_immutable
class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});
  TaskController taskController = Get.find<TaskController>();
  CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          categoryController.countAllItemsCategories();
          Get.offAllNamed(PageName.categoryPage);
          return true;
        },
        child: Scaffold(
          backgroundColor: taskController.categoryModel.value.color,
          body: Stack(
            children: [TopSection(), BottomSection()],
          ),
          floatingActionButton: MyFloatingActionButton(
            onPressed: () {
              Get.toNamed(PageName.addEditTaskPage);
            },
            color: taskController.categoryModel.value.color!,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BottomSection extends StatelessWidget {
  BottomSection({
    super.key,
  });
  TaskController taskController = Get.find<TaskController>();
  CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(34.0, 24, 34.0, 0),
        width: Get.width,
        height: Get.height / 1.55,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: SolidColors.card,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PastTaskList(taskController: taskController),
              // const Divider(),
              AllTaskList(),
              const Divider(),
              CompleteTaskList(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CompleteTaskList extends StatelessWidget {
  CompleteTaskList({
    super.key,
  });

  TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpandablePanel(
        // controller:
        //     ExpandableController(initialExpanded: false),
        header: const Text(
          'انجام شده',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        collapsed: const SizedBox(),
        expanded: taskController.categoryModel.value.completeTaskList!.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    MyStrings.noTaskComplete,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              )
            : SizedBox(
                width: Dimens.width,
                height: taskController
                        .categoryModel.value.completeTaskList!.length *
                    100,
                child: ListView.separated(
                  itemCount: taskController
                      .categoryModel.value.completeTaskList!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 85,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                taskController.categoryModel.value
                                    .completeTaskList![index].name!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Text(
                                taskController.categoryModel.value
                                    .completeTaskList![index].alarm!,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                "اولویت : ${taskController.categoryModel.value.completeTaskList![index].importance!}",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: taskController.categoryModel.value
                                      .completeTaskList![index].isComplete,
                                  onChanged: (value) {
                                    if (taskController
                                            .categoryModel
                                            .value
                                            .completeTaskList![index]
                                            .isComplete ==
                                        true) {
                                      taskController.categoryModel
                                          .update((val) {
                                        val!.completeTaskList![index]
                                            .isComplete = false;
                                      });
                                      taskController
                                          .categoryModel.value.allTaskList!
                                          .add(taskController.categoryModel
                                              .value.completeTaskList![index]);
                                      taskController
                                          .categoryModel.value.completeTaskList!
                                          .removeAt(index);
                                    }
                                  },
                                  activeColor:
                                      taskController.categoryModel.value.color,
                                ),
                              ),
                              const Spacer()
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AllTaskList extends StatelessWidget {
  AllTaskList({
    super.key,
  });
  CategoryController categoryController = Get.find<CategoryController>();
  TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpandablePanel(
        header: const Text(
          'همه',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        collapsed: const SizedBox(),
        expanded: taskController.categoryModel.value.allTaskList!.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    MyStrings.noTaskHere,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              )
            : SizedBox(
                width: Dimens.width,
                height: taskController.categoryModel.value.allTaskList!.length *
                    100,
                child: ListView.separated(
                  itemCount:
                      taskController.categoryModel.value.allTaskList!.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        List<TaskModel> list =
                            taskController.categoryModel.value.allTaskList!;
                        taskController.goToEditAllTask(index, list);
                      },
                      child: Container(
                        height: 85,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  taskController.categoryModel.value
                                      .allTaskList![index].name!,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  taskController.categoryModel.value
                                      .allTaskList![index].alarm!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "اولویت : ${taskController.categoryModel.value.allTaskList![index].importance!}",
                                  style: MyTextStyles
                                      .importanceTextTaskListPageAll,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: taskController.categoryModel.value
                                        .allTaskList![index].isComplete,
                                    onChanged: (value) {
                                      if (taskController.categoryModel.value
                                              .allTaskList![index].isComplete ==
                                          false) {
                                        taskController.categoryModel
                                            .update((val) {
                                          val!.allTaskList![index].isComplete =
                                              true;
                                        });
                                        taskController.categoryModel.value
                                            .completeTaskList!
                                            .add(taskController.categoryModel
                                                .value.allTaskList![index]);
                                        taskController
                                            .categoryModel.value.allTaskList!
                                            .removeAt(index);
                                      }
                                    },
                                    activeColor: taskController
                                        .categoryModel.value.color,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
      ),
    );
  }
}

class PastTaskList extends StatelessWidget {
  const PastTaskList({
    super.key,
    required this.taskController,
  });

  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      // controller:
      //     ExpandableController(initialExpanded: false),
      header: const Text(
        'گذشته',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
      collapsed: const SizedBox(),
      expanded: taskController.categoryModel.value.lastTaskList!.isEmpty
          ? const SizedBox()
          : SizedBox(
              width: Dimens.width,
              height:
                  taskController.categoryModel.value.lastTaskList!.length * 65,
              child: ListView.builder(
                itemCount:
                    taskController.categoryModel.value.lastTaskList!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    height: 65,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskController.categoryModel.value
                                  .lastTaskList![index].name!,
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            const Text(
                              '',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            )
                          ],
                        ),
                        Radio(
                          value: 0,
                          groupValue: 1,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class TopSection extends StatelessWidget {
  TopSection({
    super.key,
  });
  CategoryController categoryController = Get.find<CategoryController>();
  TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppBar(),
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
                    color: SolidColors.card,
                  ),
                  child: ImageIcon(
                    taskController.categoryModel.value.icon,
                    color: taskController.categoryModel.value.color,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  taskController.categoryModel.value.name!,
                  style: MyTextStyles.bigTextWhite,
                ),
                Obx(
                  () => Text(
                    '${taskController.categoryModel.value.allTaskList!.length} یادداشت',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget {
  MyAppBar({
    super.key,
  });
  CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              categoryController.countAllItemsCategories();
              Get.offAllNamed(PageName.categoryPage);
            },
            icon: ImageIcon(
              MyIcons.arrowRight,
              color: Colors.white,
            ),
          ),
          DropdownTaskList()
        ],
      ),
    );
  }
}
