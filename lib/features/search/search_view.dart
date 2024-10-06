import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/widgets/search/search_task_widget.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/icons.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.backGround,
      appBar: AppBar(
        title: const Text('جستجو', style: LightTextStyles.titleOfAppBar),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          color: Colors.black,
          icon: ImageIcon(
            MyIcons.arrowRight.image,
            size: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'جستجو ماموریت',
                    icon: IconButton(
                      onPressed: () {},
                      icon: ImageIcon(MyIcons.search.image),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text(
                  'نتایج جستجو',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  width: AppDimens.infinity,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => const SearchTaskWidget(),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: 13,
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
