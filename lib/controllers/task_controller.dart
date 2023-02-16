import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/models/category_model.dart';

class TaskController extends GetxController {
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  TextEditingController taskEditingController = TextEditingController();

  addTask() {}
}
