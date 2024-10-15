import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';
import 'package:todo_infinity_app/features/task/views/widgets/todo_category.dart';
import '../../features/main/main_category/view_model/main_category_view_model.dart';
import '../values/dimens.dart';

void taskCategoryBottomSheet(BuildContext context) {
  final MainCategoryViewModel categoryVM = Get.put(MainCategoryViewModel());
  Get.bottomSheet(
    backgroundColor: Colors.transparent,
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      height: AppDimens.sizeOfDevice(context).height * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radius),
        color: Colors.white,
      ),
      width: AppDimens.sizeOfDevice(context).width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'تغییر دسته بندی :',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
                color: Colors.grey,
              )
            ],
          ),
          Gap(AppDimens.high),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 30,
                mainAxisExtent: 40,
                mainAxisSpacing: 12),
            shrinkWrap: true,
            itemBuilder: (context, index) => TaskSinglePageCategory(
              title: categoryVM.model.categoryList[index].title,
              bgColor:
                  colorList[categoryVM.model.categoryList[index].colorIndex],
              isEmpty: false.obs,
              icon: iconList[categoryVM.model.categoryList[index].iconIndex]
                  .image,
              onTap: () {
                Get.find<TaskViewModel>().model.categoryModel = categoryVM.model.categoryList[index];
                Get.back();
              },
            ),
            itemCount: categoryVM.model.categoryList.length,
          ),
        ],
      ),
    ),
  );
}
