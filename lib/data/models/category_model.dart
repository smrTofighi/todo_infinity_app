import 'package:todo_infinity_app/data/models/task_model.dart';

class CategoryModel {
  int? id;
  String? title;
  int? icon;
  List<TaskModel>? todoListOn;
  List<TaskModel>? todoListOff;
  int? color;

  CategoryModel({
    this.id,
    this.title,
    this.icon,
    this.color,
    this.todoListOn,
    this.todoListOff,
  });

  CategoryModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    icon = element['icon'];
    todoListOn = [];
    todoListOff = [];
    color = element["color"];
  }
}
