import 'package:get/get.dart';
import 'package:todo_infinity_app/binding.dart';
import 'package:todo_infinity_app/core/routes/pages.dart';
import 'package:todo_infinity_app/features/main/main_page.dart';
import 'package:todo_infinity_app/features/search/search_view.dart';
import 'package:todo_infinity_app/features/splash/splash_page.dart';
import 'package:todo_infinity_app/features/task/views/pages/task_single_page.dart';
import 'package:todo_infinity_app/features/task/views/pages/task_list_page.dart';
import 'package:todo_infinity_app/features/auth/views/pages/login_page.dart';
import 'package:todo_infinity_app/features/auth/views/pages/signup_page.dart';

List<GetPage> routes = [
  GetPage(
    name: PageName.signUp,
    page: () => const SignUpPage(),
  ),
  GetPage(
    name: PageName.logIn,
    page: () => const LogInPage(),
  ),
  GetPage(
    name: PageName.splashView,
    page: () => const SplashPage(),
  ),
  GetPage(
    name: PageName.main,
    page: () => MainView(),
    bindings: [CategoryBinding(), TaskBinding()],
  ),
  GetPage(
      name: PageName.taskListView,
      page: () => TaskListPage(),
      binding: TaskBinding()),
  GetPage(
    name: PageName.taskSingleView,
    page: () => const TaskSinglePage(),
  ),
  GetPage(
    name: PageName.search,
    page: () => const SearchView(),
  ),
];
