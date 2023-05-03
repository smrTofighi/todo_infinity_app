import 'package:get/get.dart';
import 'package:todo_infinity_app/bindings/binding.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/pages/category/category_page.dart';
import 'package:todo_infinity_app/views/pages/category/main_category_page.dart';
import 'package:todo_infinity_app/views/pages/search/search_page.dart';
import 'package:todo_infinity_app/views/pages/tasks/add_edit_task_page.dart';
import 'package:todo_infinity_app/views/pages/tasks/task_list_page.dart';

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
    name: PageName.addEditTaskPage,
    page: () => const AddEditTaskPage(),
  ),
 
  GetPage(
    name: PageName.mainCategoryPage,
    page: () => MainCategoryPage(),
  ),
  GetPage(
    name: PageName.searchPage,
    page: () => const SearchPage(),
  ),
];
