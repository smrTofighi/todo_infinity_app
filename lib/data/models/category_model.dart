import 'package:todo_infinity_app/data/models/task_model.dart';

class CategoryModel {
  int? id;
  String? name;
  int? icon;
  List<TaskModel>? todoList;
  int? color;

  CategoryModel({
    this.id,
    this.name,
    this.icon,
    this.color,
    this.todoList,
  });

  CategoryModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    name = element["title"];
    icon = element['icon'];
    todoList = [];
    color = element["color"];
  }
}
