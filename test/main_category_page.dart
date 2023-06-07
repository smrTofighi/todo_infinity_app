import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/modules/category/controller.dart';
import 'package:todo_infinity_app/modules/category/widgets/drowdown_main_widget.dart';
import 'package:todo_infinity_app/modules/task_list/controller.dart';
import 'package:todo_infinity_app/routes/pages.dart';



// ignore: must_be_immutable
class MainCategoryPage extends StatelessWidget {
  MainCategoryPage({super.key});
  var taskController = Get.find<TaskListController>();
  var categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: categoryController
            .colorList[categoryController.categoryList[0].color!],
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
  final TaskListController taskController;

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
        child: categoryController.categoryList.length == 1
            ? const Center(
                child: Text('هیچ دسته بندی وجود ندارد'),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryController.categoryList.length - 1,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => AllTaskList(index: index),
                separatorBuilder: (context, index) => const Divider(),
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
  TaskListController taskController = Get.find<TaskListController>();
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpandablePanel(
        header: Text(
          categoryController.categoryList[index + 1].name!,
          style: TextStyle(
            color: categoryController
                .colorList[categoryController.categoryList[index + 1].color!],
            fontSize: 14,
          ),
        ),
        collapsed: const SizedBox(),
        expanded: categoryController
                .categoryList[index + 1].allTaskList!.isEmpty
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
                width: Dimens.infinity,
                height: categoryController
                        .categoryList[index + 1].allTaskList!.length *
                    85,
                child: ListView.separated(
                  itemCount: categoryController
                      .categoryList[index + 1].allTaskList!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
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
                        onTap: () {
                          taskController.categoryModel.value =
                              categoryController.categoryList[index + 1];
                          Get.toNamed(PageName.taskListPage);
                        },
                        onLongPress: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    categoryController.categoryList[index + 1]
                                        .allTaskList![index].time!,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  Text(
                                    categoryController.categoryList[index + 1]
                                        .allTaskList![index].date!,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(4, 0, 12, 0),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 2.0),
                                height: 45,
                                width: MediaQuery.of(context).size.width / 1.55,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.radius),
                                  color: SolidColors.card,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        spreadRadius: 0.2)
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      categoryController.categoryList[index + 1]
                                          .allTaskList![index].name!,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );

                    //  return Container(
                    //   height: 85,
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             categoryController.categoryList[index + 1]
                    //                 .allTaskList![index].name!,
                    //             style: const TextStyle(fontSize: 15),
                    //           ),
                    //           Text(
                    //             categoryController.categoryList[index + 1]
                    //                 .allTaskList![index].date!,
                    //             style: const TextStyle(fontSize: 12),
                    //           ),
                    //           Text(
                    //             "اولویت : ${categoryController.categoryList[index + 1].allTaskList![index].time!}",
                    //             style:
                    //                 MyTextStyles.importanceTextTaskListPageAll,
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: const [],
                    //       )
                    //     ],
                    //   ),
                    // );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
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
  final TaskListController taskController;

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
                    Image.asset(categoryController.categoryList[0].icon!).image,
                    color: categoryController
                        .colorList[categoryController.categoryList[0].color!],
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
              Image.asset(MyIcons.arrowRight).image,
              color: Colors.white,
            ),
          ),
          DropdownMainCategory(),
        ],
      ),
    );
  }
}
