import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/views/widgets/floating_action_button.dart';

// ignore: must_be_immutable
class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});
  var taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: taskController.categoryModel.value.color,
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 46),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: ImageIcon(
                          MyIcons.arrowRight,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          MyIcons.menuVertical,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 40, 24),
                  child: SizedBox(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: SolidColors.card,
                          ),
                          child: ImageIcon(
                            taskController.categoryModel.value.icon,
                            color: taskController.categoryModel.value.color,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          taskController.categoryModel.value.name!,
                          style: MyTextStyles.bigTextWhite,
                        ),
                        Text(
                          '${taskController.categoryModel.value.taskList!.length} یادداشت',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(34.0, 24, 34.0, 0),
                width: Get.width,
                height: Get.height / 1.55,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: SolidColors.card,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandablePanel(
                        // controller:
                        //     ExpandableController(initialExpanded: false),
                        header: const Text(
                          'گذشته',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ExpandablePanel(
                        // controller:
                        //     ExpandableController(initialExpanded: false),
                        header: const Text(
                          'امروز',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),

                        // controller: ExpandableController(initialExpanded: true),
                        collapsed: const SizedBox(),
                        expanded: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ExpandablePanel(
                        // controller:
                        //     ExpandableController(initialExpanded: false),
                        header: const Text(
                          'همه',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ExpandablePanel(
                        // controller:
                        //     ExpandableController(initialExpanded: false),
                        header: const Text(
                          'انجام شده',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'خرید تخم مرغ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '25 فروردین - 1401',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Radio(
                                    value: 0,
                                    groupValue: 1,
                                    onChanged: (value) {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: MyFloatingActionButton(
          onPressed: () {},
          color: taskController.categoryModel.value.color!,
        ),
      ),
    );
  }
}
