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
    MyIcons.home,
    MyIcons.airplan,
    MyIcons.dream,
    MyIcons.book,
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
    Colors.purple,
    Colors.amber,
    Colors.cyan,
    Colors.lime,
    Colors.pink,
    Colors.teal
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
              height: 45,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: iconList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        iconIndex.value = index;
                      },
                      child: AnimatedContainer(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        duration: const Duration(seconds: 1),
                        child: ImageIcon(
                          size: 35,
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              width: Dimens.width,
              height: 24,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: colorList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Obx(
                  () => ColorWidget(
                    color: index == colorIndex.value
                        ? colorList[index]
                        : colorList[index].withOpacity(0.6),
                    onTap: () {
                      colorIndex.value = index;
                    },
                  ),
                ),
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
                      Get.back();
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
