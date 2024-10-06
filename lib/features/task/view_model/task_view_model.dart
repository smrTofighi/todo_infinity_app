import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/data/models/category_model.dart';
import 'package:todo_infinity_app/features/task/model/task_model.dart';

class TaskViewModel extends GetxController {
  final RxBool isLoading = RxBool(false);
  final TextEditingController todoEditingController = TextEditingController();
  late TaskModel _model;
  TaskModel get model => _model;
  TaskViewModel() {
    _model = TaskModel();
  }

  setCategory(CategoryModel category) {
    _model.categoryModel = category;
    update();
  }

  void getTodos() async{
    isLoading(true);
  var res = await  _model.getTodoList();
  res.fold((l) {
    isLoading(false);
  }, (r) {
    isLoading(false);
    update();
  },);

  }

  void addTodo() async {
    isLoading(true);
    var res = await _model.addTodo(title: todoEditingController.text, isCompleted: false);
    res.fold(
      (failure) {
        isLoading(false);
        log(failure.message);
      },
      (document) {
        isLoading(false);
        log(document.data.toString());
      },
    );
  }
}
