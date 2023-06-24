class TaskModel {
  int? id;
  String? subject;
  String? description;
  String? date;
  String? time;
  int? category;
  String? status;

  TaskModel({
    this.id,
    this.subject,
    this.description,
    this.time,
    this.date,
    this.category,
    this.status,
  });

  TaskModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    subject = element['subject'];
    description = element['description'];
    category = element['category'];
    date = element['dueDate'];
    status = element['status'];
    time = '';
  }
}
