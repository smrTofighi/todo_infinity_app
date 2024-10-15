import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';


class TaskSinglePageCategory extends StatelessWidget {
  const TaskSinglePageCategory(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.isEmpty,
      required this.icon,
      required this.onTap});

  final String title;
  final Color bgColor;
  final RxBool isEmpty;
  final ImageProvider icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius),
          color: isEmpty.value ? Colors.transparent : bgColor.withOpacity(0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ImageIcon(
              isEmpty.value ? MyIcons.tags.image : icon,
              size: 20,
              color: isEmpty.value ? Colors.grey : Colors.white,
            ),
            Text(
              isEmpty.value ? 'انتخاب دسته بندی' : title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: isEmpty.value ? Colors.grey : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
