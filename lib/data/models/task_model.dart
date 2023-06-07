class TaskModel {
  String? name;
  String? date;
  String? time;
  String? category;
  bool? isComplete;

  TaskModel({
    required this.name,
    required this.time,
    required this.date,
    required this.category,
    required this.isComplete,
  });
}
