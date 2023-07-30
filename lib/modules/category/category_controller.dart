import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_infinity_app/core/utils/api_constant.dart';
import 'package:todo_infinity_app/core/utils/api_key.dart';
import 'package:todo_infinity_app/data/services/dio_service.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import '../../core/utils/loading_dialog.dart';
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
  RxBool loading = false.obs;

  

  @override
  void onInit() async {
    super.onInit();
    await getCategoryList();
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

  deleteCategory(
    int index,
  ) async {
    loadingDialog();
    String id = categoryList[index].id.toString();
    String url = ApiConstant.categoryDeleteApi(id);

    var response = await DioService().deleteMethod(url);

    if (response.data[ApiKey.success] == true) {
      categoryList.removeAt(index);
    }
    Get.back();
  }

  //? add category in server and variables
  addCategory() async {
    loadingDialog();
    String title = textEditingCategory.text;
    String icon = iconIndex.value.toString();
    String color = colorIndex.value.toString();
    String url = ApiConstant.categoryAddApi(title, icon, color);
    var response = await DioService().postMethod(url);
    try {
      if (response.data[ApiKey.success] == true) {
        var id = response.data[ApiKey.data]['id'];
        CategoryModel model = CategoryModel(
            id: id,
            title: title,
            color: colorIndex.value,
            icon: iconIndex.value);
        categoryList.add(model);
      }
    } catch (error) {
      log(error.toString());
    }
    clearInputs();
    Get.back();
    Get.back();
  }

  //? get category list and add in categoryList
  getCategoryList() async {
    var response = await DioService().getMethod(ApiConstant.getCategoryListApi);

    if (response.data[ApiKey.success] == true) {
      response.data['data'].forEach((element) {
        categoryList.add(CategoryModel.fromJson(element));
      });
    } else {
      log('false');
    }
  }
}
