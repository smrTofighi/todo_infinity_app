// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo_infinity_app/data/models/todo_model.dart';

class CategoryModel {
  String id;
  String title;
  int iconIndex;
  int colorIndex;
  int totalTodos;
  int completedTodos;
  double percentage;
  RxList<TodoModel>? activeTodos = RxList();
  RxList<TodoModel>? unActiveTodos= RxList();
  CategoryModel({
    required this.id,
    required this.title,
    required this.iconIndex,
    required this.colorIndex,
    this.totalTodos = 0,
    this.completedTodos = 0,
    this.percentage = 0.0,
    this.activeTodos,
    this.unActiveTodos
  });

  CategoryModel copyWith({
    String? id,
    String? title,
    int? iconIndex,
    int? colorIndex,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      iconIndex: iconIndex ?? this.iconIndex,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'icon_index': iconIndex,
      'color_index': colorIndex,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      title: map['title'] as String,
      iconIndex: map['icon_index'] as int,
      colorIndex: map['color_index'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(id: $id, title: $title, icon_index: $iconIndex, color_index: $colorIndex)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.iconIndex == iconIndex &&
        other.colorIndex == colorIndex;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        iconIndex.hashCode ^
        colorIndex.hashCode;
  }
}
