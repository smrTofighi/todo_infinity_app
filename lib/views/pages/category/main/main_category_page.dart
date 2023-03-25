import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/pages/category/main/widgets/drowdown_main_widget.dart';
import '../../../../controllers/category_controller.dart';

// ignore: must_be_immutable
class MainCategoryPage extends StatelessWidget {
  MainCategoryPage({super.key});
  var taskController = Get.find<TaskController>();
  var categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: categoryController.categoryList[0].color,
        body: Stack(
          children: [
            TopSection(
              taskController: taskController,
              categoryController: categoryController,
            ),
            BottomSection(
              taskController: taskController,
              categoryController: categoryController,
            )
          ],
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
    required this.taskController,
    required this.categoryController,
  });
  final CategoryController categoryController;
  final TaskController taskController;

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
              ListView.separated(
                shrinkWrap: true,
                itemCount: categoryController.categoryList.length - 1,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => AllTaskList(index: index),
                separatorBuilder: (context, index) => const Divider(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CompleteTaskList extends StatelessWidget {
  const CompleteTaskList({
    super.key,
    required this.taskController,
  });

  final TaskController taskController;

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
            ? const SizedBox()
            : SizedBox(
                width: Dimens.width,
                height: taskController
                        .categoryModel.value.completeTaskList!.length *
                    65,
                child: ListView.separated(
                  itemCount: taskController
                      .categoryModel.value.completeTaskList!.length,
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
                                    .completeTaskList![index].name!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const Text(
                                '',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              )
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
    required this.index,
  });
  CategoryController categoryController = Get.find<CategoryController>();
  TaskController taskController = Get.find<TaskController>();
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpandablePanel(
        header: Text(
          categoryController.categoryList[index + 1].name!,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        collapsed: const SizedBox(),
        expanded: categoryController
                .categoryList[index + 1].allTaskList!.isEmpty
            ? const SizedBox()
            : SizedBox(
                width: Dimens.width,
                height: categoryController
                        .categoryList[index + 1].allTaskList!.length *
                    65,
                child: ListView.separated(
                  itemCount: categoryController
                      .categoryList[index + 1].allTaskList!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 65,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoryController.categoryList[index + 1]
                                    .allTaskList![index].name!,
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                categoryController.categoryList[index + 1]
                                    .allTaskList![index].alarm!,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                "اولویت : ${categoryController.categoryList[index + 1].allTaskList![index].importance!}",
                                style:
                                    MyTextStyles.importanceTextTaskListPageAll,
                              ),
                            ],
                          ),
                          Column(
                            children: const [],
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

class TopSection extends StatelessWidget {
  const TopSection(
      {super.key,
      required this.taskController,
      required this.categoryController});
  final CategoryController categoryController;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyAppBar(),
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
                    categoryController.categoryList[0].icon,
                    color: categoryController.categoryList[0].color,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  categoryController.categoryList[0].name!,
                  style: MyTextStyles.bigTextWhite,
                ),
                Obx(
                  () => Text(
                    '${categoryController.allCountItemsCategories.value} یادداشت',
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

class MyAppBar extends StatelessWidget {
  const MyAppBar({
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
              Get.offAllNamed(PageName.categoryPage);
            },
            icon: ImageIcon(
              MyIcons.arrowRight,
              color: Colors.white,
            ),
          ),

          const DropdownMainCategory(),
          // IconButton(
          //   onPressed: () {},
          //   icon: ImageIcon(
          //     MyIcons.menuVertical,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}


