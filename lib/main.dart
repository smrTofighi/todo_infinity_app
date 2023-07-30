import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_infinity_app/bindings/binding.dart';
import 'package:todo_infinity_app/core/themes/dark_theme.dart';
import 'package:todo_infinity_app/modules/register/register_controller.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/routes/routes.dart';
import 'core/themes/light_theme.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo Infinity',
      debugShowCheckedModeBanner: false,
      theme:lightTheme(),
      darkTheme:darkTheme(),
      themeMode: Get.put(RegisterController()).theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'), // Farsi, IRAN
      ],
      locale: const Locale('fa', 'IR'),
      initialBinding: RegisterBinding(),
      getPages: routes,
      initialRoute: PageName.splashPage,
    );
  }
}
