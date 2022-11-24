import 'package:flutter/material.dart';
import 'package:todo_infinity_app/models/task_model.dart';

// part 'category_model.g.dart';

class CategoryModel {
  String? name;

  ImageProvider? icon;

  List<TaskModel> taskList;
  CategoryModel(
      {required this.name, required this.icon, required this.taskList});
}
