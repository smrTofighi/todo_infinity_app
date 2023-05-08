import 'package:hive/hive.dart';

import '../../models/category_model.dart';

class StorageKey {
  StorageKey._();
  static const String seen = 'seen';
  static const String categoryBox = 'categoryBox';
}

class BoxesKey {
  BoxesKey._();
  static Box<CategoryModel> categoryBox =
      Hive.box<CategoryModel>(StorageKey.categoryBox);
}
