import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/modules/register/register_controller.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/dimens.dart';
import '../../../../core/values/icons.dart';
import '../category/category_controller.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({
    super.key,
  });
  CategoryController categoryController = Get.find<CategoryController>();
  RegisterController registerController = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              width: Dimens.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        MyIcons.moon.image,
                        size: 19,
                        color: LightColors.primary,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'پس زمینه شب',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Obx(
                    () => Switch.adaptive(
                      value: registerController.isDarkMode.value,
                      onChanged: (newValue) {
                        registerController.isDarkMode.value = newValue;
                        registerController.switchTheme(
                            newValue ? ThemeMode.dark : ThemeMode.light);
                      },
                      activeColor: LightColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: LightColors.grey,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              width: Dimens.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        MyIcons.share.image,
                        size: 19,
                        color: LightColors.primary,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'معرفی به دوستان',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              width: Dimens.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        MyIcons.questionSquare.image,
                        size: 19,
                        color: LightColors.primary,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'درباره ما',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              width: Dimens.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        MyIcons.power.image,
                        size: 19,
                        color: LightColors.primary,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'خروج',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
