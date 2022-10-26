import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/gen/assets.gen.dart';
import 'package:todo_infinity_app/models/fake_data.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SolidColors.backGround,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //? appBar
            Padding(
              padding:
                  const EdgeInsets.only(right: 12.0, top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      Image.asset(Assets.icons.menu.path).image,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 16, 12),
                child: Text(
                  MyStrings.lists,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
              ),
            ),
            SizedBox(
              width: Get.width,
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: lists.length + 1,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.9),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {},
                      splashColor: Colors.transparent,
                      child: Container(
                        width: Get.width / 2.2,
                        height: Get.height / 3.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: SolidColors.card,
                          boxShadow: [
                            BoxShadow(
                              color: ShadowColor.black,
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: index == lists.length
                            ? const Icon(FontAwesomeIcons.plus)
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 24, 24, 32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ImageIcon(
                                      Image.asset(Assets.icons.notebook.path)
                                          .image,
                                      color: SolidColors.primery,
                                      size: 34,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lists[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const Text('10 یادداشت'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: SolidColors.primery,
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
