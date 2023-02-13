import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/gen/assets.gen.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/widgets/floating_action_button.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  var categoryController = Get.find<CategoryController>();
  var taskController = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.backGround,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MyAppBar(),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 16, 12),
                  child: Text(
                    MyStrings.lists,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                ),
              ),
              Obx(
                () => SizedBox(
                  width: Get.width,
                  child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: categoryController.categoryList.length + 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.9),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            if (index ==
                                categoryController.categoryList.length) {
                              categoryController.addCategory();
                            } else {
                              taskController.categoryModel.value =
                                  categoryController.categoryList[index];
                              Get.toNamed(PageName.taskListPage);
                            }
                          },
                          onLongPress: () {
                            if (index !=
                                categoryController.categoryList.length) {
                              categoryController.categoryList.removeAt(index);
                            }
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
                            child: index ==
                                    categoryController.categoryList.length
                                ? const Icon(FontAwesomeIcons.plus)
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, right: 12),
                                        child: ImageIcon(
                                          categoryController
                                              .categoryList[index].icon,
                                          color: categoryController
                                              .categoryList[index].color,
                                          size: 34,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12.0, left: 12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              categoryController
                                                  .categoryList[index].name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              '${categoryController.categoryList[index].taskList!.length} عدد',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                        child: LinearPercentIndicator(
                                          progressColor: categoryController
                                              .categoryList[index].color,
                                          percent: 1,
                                          padding: const EdgeInsets.all(0),
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
              )
            ],
          ),
        ),
        floatingActionButton: MyFloatingActionButton(
          onPressed: () {},
          color: SolidColors.primary,
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 8.0, bottom: 8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: ImageIcon(
              Image.asset(Assets.icons.menu.path).image,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
