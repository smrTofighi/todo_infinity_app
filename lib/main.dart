import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_infinity_app/bindings/binding.dart';
import 'package:todo_infinity_app/gen/fonts.gen.dart';
import 'package:todo_infinity_app/routes/routes.dart';
import 'package:todo_infinity_app/views/pages/splash_page.dart';

void main() async {
  await GetStorage.init();
  await Hive.initFlutter();
  //TODO: init Hive and register adaptor
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo Infinity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: FontFamily.samim),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'), // Farsi, IRAN
      ],
      locale: const Locale('fa', 'IR'),
      initialBinding: CategoryBinding(),
      getPages: routes,
      home: const SplashPage(),
    );
  }
}
