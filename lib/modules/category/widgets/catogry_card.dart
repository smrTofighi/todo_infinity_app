import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_infinity_app/gen/fonts.gen.dart';

import '../../../core/styles/text_styles.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/icons.dart';
import '../../task/task_controller.dart';
import '../category_controller.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({Key? key, required this.index}) : super(key: key);
  final int index;
  final CategoryController categoryController = Get.find<CategoryController>();
  final TaskController taskController = Get.find<TaskController>();
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
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                  offset: const Offset(0.5, 0.5),
                  spreadRadius: 4)
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
                      categoryController.categoryList[index].title!,
                      overflow: TextOverflow.ellipsis,
                      style: LightTextStyles.categoryNameTitleBlack,
                    ),
                    const Text(
                      '0 ماموریت',
                      style: TextStyle(
                          fontSize: 14,
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
    taskController.getTaskList();
  }
}
