import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/modules/task/widgets/task_widget.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import '../../../core/values/strings.dart';
import '../category/category_controller.dart';
import '../widgets/floating_action_button.dart';
import 'task_controller.dart';
import 'widgets/dropdown_task_list_widget.dart';

class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});
  final TaskController taskController = Get.find<TaskController>();
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(PageName.mainPage);
          return true;
        },
        child: Scaffold(
          backgroundColor: colorList[taskController.categoryModel.value.color!],
          body: Stack(
            children: [
              TopSection(),
              BottomSection(),
            ],
          ),
          floatingActionButton: MyFloatingActionButton(
            onPressed: () {
              Get.toNamed(PageName.taskInfoPage);
            },
            icon: FontAwesomeIcons.plus,
            color: colorList[taskController.categoryModel.value.color!],
          ),
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  BottomSection({
    super.key,
  });
  final TaskController taskController = Get.find<TaskController>();
  final CategoryController categoryController = Get.find<CategoryController>();

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
          borderRadius: const   BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).cardColor,
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
        expanded: taskController.categoryModel.value.todoListOff!.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    PersianStrings.noTaskComplete,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              )
            : SizedBox(
                width: Dimens.infinity,
                height:
                    taskController.categoryModel.value.todoListOff!.length * 75,
                child: Obx(
                  () => ListView.builder(
                    itemCount:
                        taskController.categoryModel.value.todoListOff!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return TaskCompleteWidget(index: index);
                    },
                    shrinkWrap: true,
                  ),
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
        expanded: taskController.categoryModel.value.todoListOn!.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    PersianStrings.noTaskHere,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              )
            : SizedBox(
                width: Dimens.infinity,
                height:
                    taskController.categoryModel.value.todoListOn!.length * 75,
                child: Obx(
                  () => ListView.builder(
                    itemCount:
                        taskController.categoryModel.value.todoListOn!.length,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TaskAllWidget(index: index);
                    },
                    shrinkWrap: true,
                  ),
                ),
              ),
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  TopSection({
    super.key,
  });
  final CategoryController categoryController = Get.find<CategoryController>();
  final TaskController taskController = Get.find<TaskController>();

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
                    color: LightColors.card,
                  ),
                  child: ImageIcon(
                    iconList[taskController.categoryModel.value.icon!].image,
                    color: colorList[taskController.categoryModel.value.color!],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  taskController.categoryModel.value.title!,
                  style: LightTextStyles.bigTextWhite,
                ),
                Obx(
                  () => Text(
                    '${taskController.categoryModel.value.todoListOn!.length} ماموریت',
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
  MyAppBar({
    super.key,
  });
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.offAllNamed(PageName.mainPage);
            },
            icon: ImageIcon(
              MyIcons.arrowRight.image,
              color: Colors.white,
            ),
          ),
          DropdownTaskList()
        ],
      ),
    );
  }
}
