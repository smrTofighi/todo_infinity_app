import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/gen/assets.gen.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/pages/category/drawer/mydrawer_widget.dart';
import 'package:todo_infinity_app/views/widgets/floating_action_button.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var categoryController = Get.find<CategoryController>();
  var taskController = Get.find<TaskController>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: MyDrawer(),
        backgroundColor: SolidColors.backGround,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, top: 8.0, bottom: 8.0, left: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _key.currentState!.openDrawer();
                      },
                      icon: ImageIcon(
                        Image.asset(Assets.icons.menu.path).image,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(PageName.searchPage);
                      },
                      icon: ImageIcon(
                        Image.asset(MyIcons.search).image,
                      ),
                    ),
                  ],
                ),
              ),
              const CategoriesText(),
              CategoryList(
                categoryController: categoryController,
                taskController: taskController,
              ),
            ],
          ),
        ),
        floatingActionButton: MyFloatingActionButton(
          onPressed: () {
            categoryController.bottomSheetAddEditCategory(context);
          },
          color: SolidColors.primary,
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categoryController,
    required this.taskController,
  });

  final CategoryController categoryController;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        child: GridView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: categoryController.categoryList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.9),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  onTapCategory(index);
                },
                onLongPress: () {
                  categoryController.deleteCateogryDialog(index, context);
                },
                child: Container(
                  width: Get.width / 2.2,
                  height: Get.height / 3.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: SolidColors.card,
                    boxShadow: [
                      BoxShadow(
                        color: ShadowColor.black,
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0, right: 12),
                        child: ImageIcon(
                          Image.asset(
                                  categoryController.categoryList[index].icon!)
                              .image,
                          color: categoryController.colorList[
                              categoryController.categoryList[index].color!],
                          size: 34,
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categoryController.categoryList[index].name!,
                              overflow: TextOverflow.ellipsis,
                              style: MyTextStyles.categoryTitleBlack,
                            ),
                            Text(
                              index == 0
                                  ? '${categoryController.allCountItemsCategories.value} مأموریت'
                                  : '${categoryController.categoryList[index].allTaskList!.length} مأموریت',
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Obx(
                        () => ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          child: LinearPercentIndicator(
                            isRTL: true,
                            progressColor: categoryController.colorList[
                                categoryController.categoryList[index].color!],
                            percent: index == 0
                                ? categoryController
                                            .completeCountItemsCategories
                                            .value ==
                                        0
                                    ? 0
                                    : categoryController
                                            .completeCountItemsCategories
                                            .value /
                                        (categoryController
                                                .allCountItemsCategories.value +
                                            categoryController
                                                .completeCountItemsCategories
                                                .value)
                                : categoryController.categoryList[index]
                                        .completeTaskList!.isEmpty
                                    ? 0.0
                                    : categoryController.categoryList[index]
                                            .completeTaskList!.length /
                                        (categoryController.categoryList[index]
                                                .completeTaskList!.length +
                                            categoryController
                                                .categoryList[index]
                                                .allTaskList!
                                                .length),
                            padding: const EdgeInsets.all(0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  onTapCategory(int index) {
    categoryController.categoryIndex.value = index;
    log(categoryController.categoryIndex.value.toString());
    if (index == 0) {
      categoryController.countAllItemsCategories();

      Get.toNamed(PageName.mainCategoryPage);
    } else {
      taskController.categoryModel.value =
          categoryController.categoryList[index];
      taskController.categoryIndex.value = index;

      Get.toNamed(PageName.taskListPage);
    }
  }
}

class CategoriesText extends StatelessWidget {
  const CategoriesText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 12, 16, 12),
        child: Text(
          MyStrings.categories,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
      ),
    );
  }
}
