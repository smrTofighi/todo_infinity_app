import 'package:flutter/material.dart';
import 'package:todo_infinity_app/models/task_model.dart';

// part 'category_model.g.dart';

class CategoryModel {
  String? name;
  ImageProvider? icon;
  List<TaskModel>? lastTaskList;
  List<TaskModel>? todayTakList;
  List<TaskModel>? allTaskList;
  List<TaskModel>? completeTaskList;
  Color? color;
  CategoryModel({this.name, this.icon, this.color, this.allTaskList, this.todayTakList, this.completeTaskList, this.lastTaskList});
}
