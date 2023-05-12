import 'package:todo_infinity_app/models/task_model.dart';

class CategoryModel {

  int? id;
  String? name;
  String? icon;
  List<TaskModel>? lastTaskList;

  List<TaskModel>? allTaskList;
  List<TaskModel>? completeTaskList;
  int? color;

  CategoryModel(
      {this.id,
      this.name,
      this.icon,
      this.color,
      this.allTaskList,
      this.completeTaskList,
      this.lastTaskList});
}
