import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/routes/pages.dart';
import '../../../../../core/values/colors.dart';
import '../../../../../core/values/dimens.dart';
import '../../../../../core/values/icons.dart';

// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerWidget(
              title: 'حساب کاربری',
              icon: MyIcons.user.image,
              color: AppColors.primary,
              onTap: () {
                Get.toNamed(PageName.profile);
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            DrawerWidget(
              title: 'درباره ما',
              icon: MyIcons.questionSquare.image,
              color: AppColors.primary,
              onTap: () {},
            ),
            DrawerWidget(
              title: 'معرفی به دوستان',
              icon: MyIcons.share.image,
              color: AppColors.primary,
              onTap: () {},
            ),
            const Divider(
              color: Colors.grey,
            ),
            DrawerWidget(
              title: 'خروج',
              icon: MyIcons.power.image,
              color: AppColors.redText,
              onTap: () {},
            ),
          ],
        ),
      )),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.onTap});
  final String title;
  final ImageProvider icon;
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        width: AppDimens.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageIcon(
                  icon,
                  size: 19,
                  color: color,
                ),
                const Gap(
                  12,
                ),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
