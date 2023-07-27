import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/modules/category/category_controller.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/icons.dart';
import '../../../core/values/strings.dart';
import 'color_widget.dart';

void bottomSheetCategory(BuildContext context) {
  CategoryController controller = Get.find<CategoryController>();
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        width: width,
        height: height / 2.2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: LightColors.card),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                controller.isEditing.value
                    ? PersianStrings.editCategory
                    : PersianStrings.newCategory,
                style: LightTextStyles.titleOfBottomSheet,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: controller.textEditingCategory,
                cursorColor: LightColors.primary,
                maxLength: 20,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'نام دسته بندی',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6.0),
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
                        controller.iconIndex.value = index;
                      },
                      child: AnimatedContainer(
                        width: 30,
                        height: 30,
                        curve: Curves.easeInOutQuint,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        duration: const Duration(seconds: 1),
                        child: ImageIcon(
                          iconList[index].image,
                          size: 35,
                          color: index == controller.iconIndex.value
                              ? colorList[controller.colorIndex.value]
                              : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              height: 34,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: colorList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Obx(
                  () => ColorWidget(
                    color: index == controller.colorIndex.value
                        ? colorList[index]
                        : colorList[index].withOpacity(0.45),
                    onTap: () {
                      controller.colorIndex.value = index;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 35,
                  width: width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.isEditing.value
                          ? controller.editCategory()
                          : controller.addCategory();
                    },
                    child: const Text(PersianStrings.add),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 35,
                  width: width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      controller.clearInputs();
                    },
                    child: const Text(PersianStrings.cancel),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: false);
}
