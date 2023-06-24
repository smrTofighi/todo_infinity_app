import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_infinity_app/core/utils/api_constant.dart';
import 'package:todo_infinity_app/core/utils/api_key.dart';
import 'package:todo_infinity_app/data/services/dio_service.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import '../../data/models/category_model.dart';

class CategoryController extends GetxController {
  //? A list of categories
  RxList<CategoryModel> categoryList = RxList();
  //? text editing controller for category name
  TextEditingController textEditingCategory = TextEditingController();
  RxInt colorIndex = 0.obs;
  RxInt iconIndex = 0.obs;
  RxInt allCountItemsCategories = 0.obs;
  RxInt completeCountItemsCategories = 0.obs;
  RxBool isEditing = false.obs;
  RxBool deleting = false.obs;

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
    var response = await DioService().getMethod(url);
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
    //TaskListController taskController = Get.find<TaskListController>();

    Get.offAllNamed(PageName.categoryPage);
    colorIndex.value = 0;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void clearInputs() {
    isEditing.value = false;
    colorIndex.value = 0;
    iconIndex.value = 0;
    textEditingCategory.text = '';
  }

  void deleteCategory(int index,) async {
    var id = categoryList[index].id;
    var response =
        await DioService().getMethod(ApiConstant.deleteCat + id.toString());
    if (response.data[ApiKey.status] == 200) {
      categoryList.removeAt(index);
     
    }
  }

  getCategoryList() async {
    var response = await DioService().getMethod(ApiConstant.getCatList);
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
}
