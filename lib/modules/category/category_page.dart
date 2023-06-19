import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import '../drawer/mydrawer_widget.dart';
import '../task_list/task_list_controller.dart';
import 'category_controller.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var categoryController = Get.find<CategoryController>();
  var taskController = Get.find<TaskListController>();
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
              const CategoriesText(),
              CategoryList(
                categoryController: categoryController,
                taskController: taskController,
              ),
            ],
          ),
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
  final TaskListController taskController;

  @override
  Widget build(BuildContext context) {
    List iconList = categoryController.iconList;
    List colorList = categoryController.colorList;

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
                int colorIndex = categoryController.categoryList[index].color!;
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
                          iconList[categoryController.categoryList[index].icon!]
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
                            const Text(
                              '0 ماموریت',
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        child: StepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 50,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              colorList[colorIndex],
                              colorList[colorIndex].withOpacity(0.5)
                            ],
                          ),
                          unselectedColor: Colors.transparent,
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
    taskController.categoryModel.value = categoryController.categoryList[index];
    taskController.categoryIndex.value = index;

    Get.toNamed(PageName.taskListPage);
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
