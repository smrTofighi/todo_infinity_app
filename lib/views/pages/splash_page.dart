import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/category_controller.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/views/widgets/loading.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.find<CategoryController>().firstSeen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.primary,
        body: SizedBox(
          width: Dimens.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Loading(),
            ],
          ),
        ),
      ),
    );
  }
}
