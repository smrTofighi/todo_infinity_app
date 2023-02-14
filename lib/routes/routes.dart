import 'package:get/get.dart';
import 'package:todo_infinity_app/bindings/binding.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/pages/category/category_page.dart';
import 'package:todo_infinity_app/views/pages/tasks/task_list_page.dart';

List<GetPage> routes = [
  GetPage(
    name: PageName.categoryPage,
    page: () => CategoryPage(),
    bindings: [CategoryBinding(), TaskBinding()],
  ),
  GetPage(
    name: PageName.taskListPage,
    page: () => TaskListPage(),
  )
];
