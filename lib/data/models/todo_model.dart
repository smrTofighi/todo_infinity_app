import 'dart:convert';
import 'dart:developer';

class TodoModel {
  String id;
  String title;
  String? description;
  bool isComplete;

  TodoModel({
    required this.id,
    required this.title,
    this.description,
    required this.isComplete,

  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isComplete,
    DateTime? time,
    int? priority,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isComplete: isComplete ?? this.isComplete,

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isComplete': isComplete,

    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
   
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      isComplete: map['isComplete'] as bool,

    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, description: $description, isComplete: $isComplete)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isComplete == isComplete ;

  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isComplete.hashCode ;
  }
}
