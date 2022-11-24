import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController());
  }
}
