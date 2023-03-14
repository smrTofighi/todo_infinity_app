class TaskModel {
  String? name;
  String? alarm;
  String? importance;
  String? category;
  bool? isComplete;

  TaskModel({
    required this.name,
    required this.importance,
    required this.alarm,
    required this.category,
    required this.isComplete,
  });
}
