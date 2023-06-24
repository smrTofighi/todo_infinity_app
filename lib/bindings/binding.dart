import 'package:get/get.dart';

import '../modules/category/category_controller.dart';
import '../modules/task_list/task_list_controller.dart';


class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController());
  }
}

class TaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TaskListController());
    //Get.put(TaskListController());
  }
}
