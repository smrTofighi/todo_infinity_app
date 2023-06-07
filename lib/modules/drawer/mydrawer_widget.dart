import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/dimens.dart';
import '../../../../core/values/icons.dart';
import '../category/controller.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({
    super.key,
  });
  CategoryController categoryController = Get.find<CategoryController>();
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
                        Image.asset(MyIcons.moon).image,
                        size: 19,
                        color: SolidColors.primary,
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
                  Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: SolidColors.primary,
                  )
                ],
              ),
            ),
            const Divider(
              color: SolidColors.grey,
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
                        Image.asset(MyIcons.share).image,
                        size: 19,
                        color: SolidColors.primary,
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
                        Image.asset(MyIcons.questionSquare).image,
                        size: 19,
                        color: SolidColors.primary,
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
                        Image.asset(MyIcons.power).image,
                        size: 19,
                        color: SolidColors.primary,
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
