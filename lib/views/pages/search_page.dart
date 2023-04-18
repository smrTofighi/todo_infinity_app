import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/styles/text_styles.dart';
import '../../core/values/colors.dart';
import '../../core/values/icons.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [TextField()],
          ),
        ),
      ),
    );
  }
}
