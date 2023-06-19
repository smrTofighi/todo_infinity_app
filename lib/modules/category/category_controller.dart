import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_infinity_app/core/utils/api_constant.dart';
import 'package:todo_infinity_app/core/utils/api_key.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/data/services/dio_service.dart';
import 'package:todo_infinity_app/modules/category/widgets/color_widget.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import '../../core/styles/text_styles.dart';
import '../../core/values/colors.dart';
import '../../data/models/category_model.dart';
import '../task_list/task_list_controller.dart';

class CategoryController extends GetxController {
  //? A list of categories
  RxList<CategoryModel> categoryList = RxList();
  //? text editing controller for category name
  TextEditingController textEditingCategory = TextEditingController();
  RxInt colorIndex = 0.obs;
  RxInt iconIndex = 0.obs;
  RxInt categoryIndex = 0.obs;
  RxInt allCountItemsCategories = 0.obs;
  RxInt completeCountItemsCategories = 0.obs;
  RxBool isEditing = false.obs;

  //? static variables
  List<Image> iconList = [
    MyIcons.tree,
    MyIcons.bed,
    MyIcons.book,
    MyIcons.books,
    MyIcons.bulb,
    MyIcons.cake,
    MyIcons.car,
    MyIcons.dollar,
    MyIcons.dream,
    MyIcons.football,
    MyIcons.gift,
    MyIcons.glassCheers,
    MyIcons.gym,
    MyIcons.moon,
    MyIcons.music,
    MyIcons.handHoldingHeart,
    MyIcons.home,
    MyIcons.volleyball,
    MyIcons.note,
    MyIcons.plane,
    MyIcons.school,
    MyIcons.shop,
    MyIcons.sunrise,
    MyIcons.work,
    MyIcons.world,
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
    Colors.teal,
    Colors.blueGrey,
    Colors.indigo,
    Colors.lightGreen
  ];

  //? this method delete your category
  deleteCateogryDialog(int index, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;

    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: SolidColors.card,
      buttonColor: SolidColors.primary,
      confirm: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        height: 30,
        width: width / 4,
        child: ElevatedButton(
          onPressed: () {
            deleteCategory(index);
            Get.back();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.redAccent),
          ),
          child: const Text(MyStrings.delete),
        ),
      ),
      cancel: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        height: 30,
        width: width / 4,
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          child: const Text(MyStrings.cancel),
        ),
      ),
      onConfirm: () {
        deleteCategory(index);
      },
      title: '',
      titleStyle: const TextStyle(fontSize: 10),
      titlePadding: const EdgeInsets.all(0),
      middleText: 'دسته بندی ${categoryList[index].name} حذف شود؟',
      radius: Dimens.radius,
    );
  }

  //? Toast Message
  toastMessage(String message, BuildContext context) {
    toastification.showSuccess(
      context: context,
      title: message,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  checkInputsForCategory(BuildContext context, String title) {
    if (textEditingCategory.text == '') {
      toastification.showError(
        context: context,
        title: title,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else {
      isEditing.value ? editCategory() : addCategory();
    }
  }

  addCategory() async {
    String title = textEditingCategory.text;
    String icon = iconIndex.value.toString();
    String color = colorIndex.value.toString();
    String url = ApiConstant.newCategory(title, color, icon);
    var response = await DioService().getMethod(ApiConstant.host + url);
    try {
      if (response.data[ApiKey.status] == 200) {
        var id = response.data[ApiKey.data]['id'];
        CategoryModel model = CategoryModel(
            id: id,
            name: title,
            color: colorIndex.value,
            icon: iconIndex.value);
        categoryList.add(model);
      }
    } catch (error) {
      log(error.toString());
    }
    clearInputs();
    Get.back();
  }

  void editCategory() {
    Get.offAllNamed(PageName.categoryPage);
    clearInputs();
  }

  void changeThemeCategory() {
    TaskListController taskController = Get.find<TaskListController>();

    if (categoryIndex.value == 0) {
      categoryList[0].color = colorIndex.value;
    } else {
      taskController.categoryModel.value.color = colorIndex.value;
    }
    Get.offAllNamed(PageName.categoryPage);
    colorIndex.value = 0;
  }

  void clearInputs() {
    isEditing.value = false;
    colorIndex.value = 0;
    iconIndex.value = 0;
    textEditingCategory.text = '';
  }

  void deleteCategory(int index) async {
    var id = categoryList[index].id;
    var response = await DioService()
        .getMethod(ApiConstant.host + ApiConstant.deleteCat + id.toString());
    if (response.data[ApiKey.status] == 200) {
      categoryList.removeAt(index);
    }
  }

  getCategoryList() async {
    var response =
        await DioService().getMethod(ApiConstant.host + ApiConstant.getCatList);
    if (response.data['status'] == 200) {
      response.data['list'].forEach((element) {
        categoryList.add(CategoryModel.fromJson(element));
      });
      Get.offNamed(PageName.mainPage);
    } else {
      log('false');
    }
  }

  Future firstSeen() async {
    //final box = GetStorage();
    //var seen = (box.read(StorageKey.seen) ?? false);
  }

//? static widgets

  void bottomSheetChoiceColor(
    BuildContext context,
    Function() onPressed,
  ) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        width: width,
        height: height / 3.8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: SolidColors.card,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                MyStrings.changeColorOfCategory,
                style: MyTextStyles.titleOfBottomSheet,
              ),
            ),
            const SizedBox(
              height: 25,
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
                    color: index == colorIndex.value
                        ? colorList[index]
                        : colorList[index].withOpacity(0.45),
                    onTap: () {
                      colorIndex.value = index;
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
                    onPressed: onPressed,
                    child: const Text(MyStrings.edit),
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
                      clearInputs();
                      Get.back();
                    },
                    child: const Text(MyStrings.cancel),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
