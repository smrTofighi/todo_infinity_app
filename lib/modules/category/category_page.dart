import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/modules/category/widgets/catogry_card.dart';
import 'category_controller.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CategoriesText(),
          CategoryList(),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  CategoryList({
    super.key,
  });

  final CategoryController controller = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Obx(
      () => SizedBox(
        width: Get.width,
        child: controller.categoryList.isEmpty
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
                itemCount: controller.categoryList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.9),
                itemBuilder: (context, index) {
                  return LongPressDraggable(
                    data: index,
                    feedback: Opacity(
                      opacity: 0.8,
                      child: CategoryCard(index: index),
                    ),
                    onDragStarted: () => controller.changeDeleting(true),
                    onDraggableCanceled: (_, __) =>
                        controller.changeDeleting(false),
                    onDragEnd: (_) => controller.changeDeleting(false),
                    child: CategoryCard(index: index),
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
