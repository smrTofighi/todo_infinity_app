class TaskModel {
  int? id;
  String? subject;
  String? description;
  String? dueDate;

  int? category;
  String? status;

  TaskModel({
    this.id,
    this.subject,
    this.description,
    this.dueDate,
    this.category,
    this.status,
  });

  TaskModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    subject = element['subject'];
    description = element['description'];
    category = element['category'];
    dueDate = element['dueDate'];
    status = element['status'];
  }
}
