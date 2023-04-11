import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/category_controller.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/dimens.dart';
import '../../../../core/values/icons.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({
    super.key,
  });
  CategoryController categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
              itemBuilder: (context, index) => ListTileCategory(index: index),
              itemCount: categoryController.categoryList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
            const Divider(
              color: SolidColors.grey,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              width: Dimens.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        MyIcons.power,
                        size: 19,
                        color: SolidColors.primary,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'خروج',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class ListTileCategory extends StatelessWidget {
  ListTileCategory({
    super.key,
    required this.index,
  });
  CategoryController categoryController = Get.find<CategoryController>();

  final int index;
  @override
  Widget build(BuildContext context) {
    var categoryList = categoryController.categoryList;
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        width: Dimens.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageIcon(
                  categoryList[index].icon,
                  size: 19,
                  color: categoryList[index].color,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  categoryList[index].name!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  child: CircleAvatar(
                    backgroundColor: categoryList[index].color,
                    child: Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          index == 0
                              ? categoryController.allCountItemsCategories
                                  .toString()
                              : categoryList[index]
                                  .allTaskList!
                                  .length
                                  .toString(),
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                ImageIcon(
                  MyIcons.menuVertical,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
