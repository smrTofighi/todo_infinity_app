import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/core/widgets/loading.dart';
import 'package:todo_infinity_app/core/widgets/main_category/catogry_card.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';
import '../../view_model/main_category_view_model.dart';

// ignore: must_be_immutable
class MainCategoryPage extends StatelessWidget {
  const MainCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CategoriesText(),
          Obx(
            () => Get.find<MainCategoryViewModel>().isLoading.value
                ? const Center(
                    child: Loading(
                      color: LightColors.primary,
                      size: 50,
                    ),
                  )
                : CategoryList(),
          )
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  CategoryList({
    super.key,
  });

  final MainCategoryViewModel categoryVM = Get.find<MainCategoryViewModel>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GetBuilder<MainCategoryViewModel>(
      builder: (vm) => SizedBox(
        width: Get.width,
        child: vm.model.categoryList.isEmpty
            ? SizedBox(
                width: size.width,
                height: size.height * 0.75,
                child: const Center(
                  child: Text(
                    'هنوز دسته بندی ساخته نشده است',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : GridView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: vm.model.categoryList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return LongPressDraggable(
                    data: index,
                    feedback: Opacity(
                      opacity: 0.8,
                      child: CategoryCard(
                        title: vm.model.categoryList[index].title,
                        index: index,
                        iconIndex: vm.model.categoryList[index].iconIndex,
                        colorIndex: vm.model.categoryList[index].colorIndex,
                        totalTodos: vm.model.categoryList[index].totalTodos,
                        percentage: vm.model.categoryList[index].percentage,
                        completedTodos:
                            vm.model.categoryList[index].completedTodos,
                        onTap: () {
                          vm.goToTaskListPage(vm.model.categoryList[index]);
                        },
                      ),
                    ),
                    onDragStarted: () => categoryVM.changeDeleting(true),
                    onDraggableCanceled: (_, __) =>
                        categoryVM.changeDeleting(false),
                    onDragEnd: (_) => categoryVM.changeDeleting(false),
                    child: CategoryCard(
                      title: vm.model.categoryList[index].title,
                      index: index,
                      iconIndex: vm.model.categoryList[index].iconIndex,
                      colorIndex: vm.model.categoryList[index].colorIndex,
                      totalTodos: vm.model.categoryList[index].totalTodos,
                      percentage: vm.model.categoryList[index].percentage,
                      completedTodos:
                          vm.model.categoryList[index].completedTodos,
                      onTap: () {
                        vm.goToTaskListPage(vm.model.categoryList[index]);
                      },
                    ),
                  );
                },
              ),
      ),
    );
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
          PersianStrings.categories,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
      ),
    );
  }
}
