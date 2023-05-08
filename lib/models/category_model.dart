import 'package:hive/hive.dart';
import 'package:todo_infinity_app/models/task_model.dart';

part 'category_model.g.dart';

@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? icon;
  @HiveField(4)
  List<TaskModel>? lastTaskList;
  @HiveField(5)
  List<TaskModel>? allTaskList;
  @HiveField(6)
  List<TaskModel>? completeTaskList;
  @HiveField(7)
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
