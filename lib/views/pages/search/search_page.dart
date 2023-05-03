import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/views/pages/search/widgets/search_task_widget.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/icons.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SolidColors.backGround,
      appBar: AppBar(
        title: const Text('جستجو', style: MyTextStyles.titleOfAppBar),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          color: Colors.black,
          icon: ImageIcon(
            MyIcons.arrowRight,
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
                      icon: ImageIcon(MyIcons.search),
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
                  width: Dimens.infinity,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => SearchTaskWidget(),
                    separatorBuilder: (context, index) => Divider(),
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
