import 'package:get/get.dart';
import 'package:todo_infinity_app/modules/register/register_controller.dart';

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

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
