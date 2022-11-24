import 'package:get/get.dart';
import 'package:todo_infinity_app/bindings/binding.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/pages/category_page.dart';
import 'package:todo_infinity_app/views/pages/task_list_page.dart';

List<GetPage> routes = [
  GetPage(
    name: PageName.categoryPage,
    page: () => CategoryPage(),
    binding: CategoryBinding(),
  ),
  GetPage(
    name: PageName.taskListPage,
    page: () => const TaskListPage(),
    // binding: CategoryBinding(),
  )
];
