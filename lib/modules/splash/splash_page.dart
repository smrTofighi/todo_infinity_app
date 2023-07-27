import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';

import '../category/category_controller.dart';
import '../widgets/loading.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Get.find<CategoryController>().getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightColors.primary,
        body: SizedBox(
          width: Dimens.infinity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Loading(),
            ],
          ),
        ),
      ),
    );
  }
}
