import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_infinity_app/gen/fonts.gen.dart';

import '../../../core/styles/text_styles.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/icons.dart';
import '../../task_list/task_list_controller.dart';
import '../category_controller.dart';

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  CategoryCard({Key? key, required this.index}) : super(key: key);
  final int index;
  CategoryController categoryController = Get.find<CategoryController>();
  TaskListController taskController = Get.find<TaskListController>();
  @override
  Widget build(BuildContext context) {
    int colorIndex = categoryController.categoryList[index].color!;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          onTapCategory(index);
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
                  iconList[categoryController.categoryList[index].icon!].image,
                  color:
                      colorList[categoryController.categoryList[index].color!],
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
                      style: TextStyle(
                          fontSize: 14,
                          color: SolidColors.black,
                          fontWeight: FontWeight.w300,
                          fontFamily: FontFamily.samim),
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
  }

  onTapCategory(int index) {
    var categoryList = categoryController.categoryList;
    taskController.categoryModel.value = categoryList[index];
    taskController.categoryIndex.value = index;
    var id = categoryList[index].id;
    taskController.categoryId.value = int.parse(id.toString());
    taskController.getTodoList();
  }
}
