import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });
}
