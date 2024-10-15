import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_infinity_app/core/gen/fonts.gen.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    required this.index,
    required this.iconIndex,
    required this.colorIndex,
    required this.onTap,
    required this.totalTodos,
    required this.percentage, required this.completedTodos,
  });
  final String title;
  final int index;
  final int iconIndex;
  final int colorIndex;
  final Function() onTap;
  final int totalTodos;
  final double percentage;
  final int completedTodos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppDimens.sizeOfDevice(context).width / 2.2,
          height: AppDimens.sizeOfDevice(context).height /4.2,
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
                child: Hero(
                  tag: 'tag $title',
                  child: ImageIcon(
                    iconList[iconIndex].image,
                    color: colorList[colorIndex],
                    size: 34,
                  ),
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
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: LightTextStyles.categoryNameTitleBlack,
                    ),
                    Text(
                      '${totalTodos - completedTodos} مأموریت',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
    decoration: TextDecoration.none,
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
                  totalSteps: totalTodos == 0 ? 1 : totalTodos,
                  currentStep: completedTodos == 0 ? 0 : completedTodos,
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
}
