import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import '../../../../../core/values/icons.dart';

// ignore: must_be_immutable
class DropdownTaskList extends StatelessWidget {
  DropdownTaskList({
    super.key,
  });
  TaskController taskController = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: SizedBox(
          width: 36,
          child: ImageIcon(
            MyIcons.menuVertical,
            color: Colors.white,
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
          MenuItems.onChanged(context, value as MenuItem);
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: taskController.categoryModel.value.color,
          ),
          elevation: 8,
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 48),
            8,
            ...List<double>.filled(MenuItems.secondItems.length, 48),
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
  static List<MenuItem> firstItems = [
    editCategory,
    editCategoryTheme,
    search,
    trashAllCategory
  ];
  static List<MenuItem> secondItems = [logout];
  static final editCategory = MenuItem(text: 'ویرایش', icon: MyIcons.edit);
  static final editCategoryTheme =
      MenuItem(text: 'تغییر رنگ', icon: MyIcons.pallete);
  static final search = MenuItem(text: 'جستجو', icon: MyIcons.search);
  static final trashAllCategory =
      MenuItem(text: 'حذف همه', icon: MyIcons.trash);
  static final logout = MenuItem(text: 'خروج', icon: MyIcons.power);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        ImageIcon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    CategoryController categoryController = Get.find<CategoryController>();
    TaskController taskController = Get.find<TaskController>();
    if (item.icon == MyIcons.pallete) {
      categoryController.changeThemeCategory(context);
    } else if (item.icon == MyIcons.edit) {
      categoryController.editCategory(context);
    } else if (item.icon == MyIcons.trash) {
      taskController.deleteTasks(context);
    }
  }
}
