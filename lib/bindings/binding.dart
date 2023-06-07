import 'package:get/get.dart';

import '../modules/category/controller.dart';
import '../modules/task_list/controller.dart';


class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController());
  }
}

class TaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskListController());
  }
}
