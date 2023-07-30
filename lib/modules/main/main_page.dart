import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/modules/category/category_controller.dart';
import 'package:todo_infinity_app/modules/category/category_page.dart';
import 'package:todo_infinity_app/modules/drawer/mydrawer_widget.dart';
import 'package:todo_infinity_app/modules/report/report_page.dart';
import '../../core/values/icons.dart';
import '../../gen/assets.gen.dart';
import '../../routes/pages.dart';
import '../category/widgets/bottom_sheet_category.dart';
import '../widgets/floating_action_button.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _ourKey = GlobalKey<ScaffoldState>();
  RxInt activeIndex = 0.obs;
  CategoryController controller = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ourKey,
     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
       backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(
              right: 12.0, top: 8.0, bottom: 8.0, left: 12.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  _ourKey.currentState!.openDrawer();
                },
                icon: ImageIcon(
                  Image.asset(Assets.icons.menu.path).image,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Get.toNamed(PageName.searchPage);
                },
                icon: ImageIcon(
                  MyIcons.search.image,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: activeIndex.value,
            children: const [
              CategoryPage(),
              ReportPage(),
            ],
          ),
        ),
      ),
      floatingActionButton: DragTarget<int>(
        builder: (_, __, ___) => Obx(
          () => MyFloatingActionButton(
            onPressed: () {
              bottomSheetCategory(context);
            },
            icon: controller.deleting.value
                ? FontAwesomeIcons.trash
                : FontAwesomeIcons.plus,
            color: controller.deleting.value ? Colors.red : LightColors.primary,
          ),
        ),
        onAccept: (index) {
          controller.deleteCategory(index);
        },
      ),
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          icons: const [
            FontAwesomeIcons.house,
            FontAwesomeIcons.chartColumn,
          ],
          inactiveColor: Theme.of(context).iconTheme.color,
          activeColor: LightColors.primary,
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
          activeIndex: activeIndex.value,
          onTap: (index) {
            activeIndex.value = index;
          },
          gapLocation: GapLocation.center,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
