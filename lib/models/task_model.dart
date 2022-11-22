import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? alarm;
  @HiveField(3)
  String? note;
  @HiveField(4)
  String? category;
  @HiveField(5)
  bool? isComplete;

  TaskModel({
    required this.id,
    required this.name,
    required this.note,
    required this.alarm,
    required this.category,
    required this.isComplete,
  });
}
