import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/models/category_model.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/pages/category/widgets/color_widget.dart';

import '../core/values/colors.dart';
import '../core/values/storages.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categoryList = RxList();
  TextEditingController textEditingCategory = TextEditingController();
  RxInt colorIndex = 0.obs;
  RxInt iconIndex = 0.obs;
  RxInt allCountItemsCategories = 0.obs;
  RxInt completeCountItemsCategories = 0.obs;
  //? static variables
  List<ImageProvider> iconList = [
    MyIcons.airplan,
    MyIcons.noteBook,
    MyIcons.book,
    MyIcons.home,
    MyIcons.music,
    MyIcons.school,
    MyIcons.shop,
    MyIcons.work,
  ];
  List<Color> colorList = [
    SolidColors.primary,
    Colors.red,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.purple
  ];
  @override
  void onInit() {
    super.onInit();
    countAllItemsCategories();
  }

  countAllItemsCategories() {
    allCountItemsCategories.value = 0;
    completeCountItemsCategories.value = 0;
    for (var category in categoryList) {
      allCountItemsCategories.value += category.allTaskList!.length;
      completeCountItemsCategories.value += category.completeTaskList!.length;
    }
  }

  addCategory() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'لیست جدید',
      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      content: SizedBox(
        width: Dimens.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingCategory,
              cursorColor: SolidColors.primary,
              maxLength: 20,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'نام لیست',
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              height: 150,
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: iconList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.7,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 25),
                itemBuilder: (context, index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        iconIndex.value = index;
                      },
                      child: AnimatedContainer(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        duration: const Duration(seconds: 1),
                        child: ImageIcon(
                          size: 20,
                          iconList[index],
                          color: index == iconIndex.value
                              ? colorList[colorIndex.value]
                              : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ColorWidget(
                    color: colorIndex.value == 0
                        ? SolidColors.primary
                        : SolidColors.primary.withOpacity(0.35),
                    onTap: () {
                      colorIndex.value = 0;
                    },
                  ),
                  ColorWidget(
                    color: colorIndex.value == 1
                        ? Colors.red
                        : Colors.red.withOpacity(0.35),
                    onTap: () {
                      colorIndex.value = 1;
                    },
                  ),
                  ColorWidget(
                    color: colorIndex.value == 2
                        ? Colors.green
                        : Colors.green.withOpacity(0.35),
                    onTap: () {
                      colorIndex.value = 2;
                    },
                  ),
                  ColorWidget(
                    color: colorIndex.value == 3
                        ? Colors.brown
                        : Colors.brown.withOpacity(0.35),
                    onTap: () {
                      colorIndex.value = 3;
                    },
                  ),
                  ColorWidget(
                    color: colorIndex.value == 4
                        ? Colors.orange
                        : Colors.orange.withOpacity(0.35),
                    onTap: () {
                      colorIndex.value = 4;
                    },
                  ),
                  ColorWidget(
                    color: colorIndex.value == 5
                        ? Colors.purple
                        : Colors.purple.withOpacity(0.35),
                    onTap: () {
                      colorIndex.value = 5;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 35,
                  width: Dimens.width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      categoryList.add(
                        CategoryModel(
                          name: textEditingCategory.text,
                          icon: iconList[iconIndex.value],
                          color: colorList[colorIndex.value],
                          allTaskList: [],
                          completeTaskList: [],
                          lastTaskList: [],
                        ),
                      );
                      textEditingCategory.text = '';
                      iconIndex.value = 0;
                      colorIndex.value = 0;
                      Get.back();
                    },
                    child: const Text('افزودن'),
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: Dimens.width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      colorIndex.value = 0;
                      iconIndex.value = 0;
                      textEditingCategory.text = '';
                    },
                    child: const Text('لغو'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      radius: 6,
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(8.0),
    );
  }

  Future firstSeen() async {
    final box = GetStorage();
    var seen = (box.read(StorageKey.seen) ?? false);
    if (seen) {
      categoryList.add(
        CategoryModel(
          name: MyStrings.all,
          icon: MyIcons.noteBook,
          color: SolidColors.primary,
          allTaskList: [],
          completeTaskList: [],
          lastTaskList: [],
        ),
      );
      Get.offNamed(PageName.categoryPage);
    } else {
      box.write(StorageKey.seen, true);
      categoryList.add(
        CategoryModel(
          name: MyStrings.all,
          icon: MyIcons.noteBook,
          color: SolidColors.primary,
          allTaskList: [],
          completeTaskList: [],
          lastTaskList: [],
        ),
      );
      Get.offNamed(PageName.categoryPage);
    }
  }
}
