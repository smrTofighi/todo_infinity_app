import 'package:get/get.dart';
import 'package:todo_infinity_app/bindings/binding.dart';
import 'package:todo_infinity_app/modules/task/view.dart';
import 'package:todo_infinity_app/routes/pages.dart';

import '../modules/category/view.dart';
import '../modules/search/view.dart';
import '../modules/task_list/view.dart';

List<GetPage> routes = [
  GetPage(
    name: PageName.categoryPage,
    page: () => const CategoryPage(),
    bindings: [CategoryBinding(), TaskBinding()],
  ),
  GetPage(
    name: PageName.taskListPage,
    page: () => TaskListPage(),
  ),
  GetPage(
    name: PageName.taskPage,
    page: () => const TaskPage(),
  ),
 
  GetPage(
    name: PageName.searchPage,
    page: () => const SearchPage(),
  ),
];
