

class TaskModel {
  String? name;
  String? alarm;
  String? note;
  String? category;
  bool? isComplete;

  TaskModel({
    required this.name,
    required this.note,
    required this.alarm,
    required this.category,
    required this.isComplete,
  });
}
