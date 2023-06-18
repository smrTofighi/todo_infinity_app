import 'package:get/get.dart';
import 'package:todo_infinity_app/bindings/binding.dart';
import 'package:todo_infinity_app/modules/main/main_page.dart';
import 'package:todo_infinity_app/modules/splash/splash_page.dart';
import 'package:todo_infinity_app/modules/task/view.dart';
import 'package:todo_infinity_app/routes/pages.dart';

import '../modules/category/category_page.dart';
import '../modules/search/view.dart';
import '../modules/task_list/task_list_page.dart';

List<GetPage> routes = [
  GetPage(
    name: PageName.categoryPage,
    page: () => const CategoryPage(),
  ),
  GetPage(
    name: PageName.splashPage,
    page: () => const SplashPage(),
  ),
  GetPage(
    name: PageName.mainPage,
    page: () => MainPage(),
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
