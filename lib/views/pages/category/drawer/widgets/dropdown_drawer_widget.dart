import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/category_controller.dart';
import '../../../../../controllers/task_controller.dart';
import '../../../../../core/values/icons.dart';

// ignore: must_be_immutable
class DropDownDrawer extends StatelessWidget {
  DropDownDrawer({Key? key, required this.index}) : super(key: key);
  CategoryController categoryController = Get.find<CategoryController>();
  final int index;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: SizedBox(
          width: 36,
          child: ImageIcon(
            MyIcons.menuVertical,
            color: Colors.black,
            size: 16,
          ),
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem, index);
        },
        dropdownStyleData: DropdownStyleData(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: categoryController.categoryList[index].color,
          ),
          elevation: 8,
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 36),
            8,
            ...List<double>.filled(MenuItems.secondItems.length, 36),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DropDownMainCategoryDrawer extends StatelessWidget {
  DropDownMainCategoryDrawer({Key? key}) : super(key: key);
  CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: SizedBox(
          width: 36,
          child: ImageIcon(
            MyIcons.menuVertical,
            color: Colors.black,
            size: 16,
          ),
        ),
        items: [
          ...MenuItems.mainFirstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem, 0);
        },
        dropdownStyleData: DropdownStyleData(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: categoryController.categoryList[0].color,
          ),
          elevation: 8,
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.mainFirstItems.length, 48),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final ImageProvider icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static List<MenuItem> mainFirstItems = [
    editCategoryTheme,
  ];
  static List<MenuItem> firstItems = [
    editCategory,
    editCategoryTheme,
  ];
  static List<MenuItem> secondItems = [delete];
  static final editCategory = MenuItem(text: 'ویرایش', icon: MyIcons.edit);
  static final editCategoryTheme =
      MenuItem(text: 'تغییر رنگ', icon: MyIcons.pallete);
  static final search = MenuItem(text: 'جستجو', icon: MyIcons.search);
  static final delete = MenuItem(text: 'حذف', icon: MyIcons.trash);
  static final deleteAllCategory =
      MenuItem(text: 'حذف همه دسته بندی ها', icon: MyIcons.trash);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        ImageIcon(item.icon, color: Colors.white, size: 14),
        const SizedBox(
          width: 5,
        ),
        Text(
          item.text,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item, int index) {
    CategoryController categoryController = Get.find<CategoryController>();
    TaskController taskController = Get.find<TaskController>();
    if (index == 0) {
      if (item.icon == MyIcons.pallete) {
        categoryController.changeThemeMainCategory(context);
      }
    } else {
      if (item.icon == MyIcons.edit) {
        taskController.categoryModel.value =
            categoryController.categoryList[index];
        categoryController.editCategoryWidget(context);
      } else if (item.icon == MyIcons.pallete) {
        categoryController.changeThemeCategory(context);
      } else if (item.icon == MyIcons.trash) {
        categoryController.deleteCateogry(index, context);
      }
    }
  }
}
