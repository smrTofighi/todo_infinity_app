// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:todo_infinity_app/core/styles/button_style.dart';
import 'package:todo_infinity_app/core/styles/extensions.dart';
import 'package:todo_infinity_app/core/styles/input_decoration.dart';
import 'package:todo_infinity_app/core/utils/note_task_dialog.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';
import 'package:todo_infinity_app/features/task/views/widgets/todo_category.dart';

import '../../../../../core/styles/text_styles.dart';

class TaskSinglePage extends StatefulWidget {
  const TaskSinglePage({super.key});

  @override
  State<TaskSinglePage> createState() => _TaskSinglePageState();
}

class _TaskSinglePageState extends State<TaskSinglePage> {
  final TaskViewModel taskVM = Get.find<TaskViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightColors.backGround,
        appBar: AppBar(
          title: const Text(PersianStrings.newTask,
              style: LightTextStyles.titleOfAppBar),
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gap(AppDimens.high * 2),
                TextFormField(
                  maxLines: 3,
                  validator: (value) {
                    if(value!.isEmpty){
                      return PersianStrings.requiredText;
                    }
                    return null;
                  },
                  controller: taskVM.todoEditingController,
                  decoration: AppInputDecoration.textFieldAddEditTaskPage,
                ),
                const Divider(),
                (AppDimens.medium * 2).height,
                TaskAlarm(),
                (AppDimens.medium * 2).height,
                TaskNote(),
                (AppDimens.medium * 2).height,
                const TodoCategory(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AddEditTaskBottomNavigation(
          formKey: _formKey,
        ),
      ),
    );
  }
}

class TaskAlarm extends StatelessWidget {
  const TaskAlarm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          MyIcons.notification.image,
          size: 18,
          color: Colors.grey,
        ),
        AppDimens.medium.width,
        TextButton(
          onPressed: () {},
          style: MyButtonStyle.textButtonAddEditTaskPage,
          child: Text(
            '',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class TaskNote extends StatelessWidget {
  TaskNote({
    super.key,
  });
  final TaskViewModel taskVM = Get.find<TaskViewModel>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => noteTaskDialog(context),
      child: Obx(
        () => Row(
          children: [
            ImageIcon(
              MyIcons.note.image,
              size: 18,
              color: taskVM.model.description.value.isEmpty
                  ? Colors.grey
                  : colorList[taskVM.model.categoryModel.colorIndex],
            ),
            AppDimens.medium.width,
            Text(
              taskVM.model.description.value.isEmpty
                  ? 'توضیحات'
                  : taskVM.model.description.value,
              style: TextStyle(
                color: taskVM.model.description.value.isEmpty
                    ? Colors.grey
                    : colorList[taskVM.model.categoryModel.colorIndex],
                fontSize: 13,
                fontWeight: taskVM.model.description.value.isEmpty
                    ? FontWeight.w300
                    : FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEditTaskBottomNavigation extends StatelessWidget {
  AddEditTaskBottomNavigation({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;

  final TaskViewModel taskVM = Get.find<TaskViewModel>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            taskVM.addTodo();
            Get.back();
          }
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              // Change your radius here
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
            colorList[taskVM.model.categoryModel.colorIndex],
          ),
        ),
        child: const Text(
          PersianStrings.add,
        ),
      ),
    );
  }
}
