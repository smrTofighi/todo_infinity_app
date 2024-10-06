import 'package:get/get.dart';
import 'package:todo_infinity_app/features/auth/view_model/auth_view_model.dart';
import 'package:todo_infinity_app/features/main/main_category/view_model/main_category_view_model.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainCategoryViewModel());
  }
}

class TaskBinding implements Bindings {
  @override
  void dependencies() {
  }
}

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthViewModel());
  }
}
