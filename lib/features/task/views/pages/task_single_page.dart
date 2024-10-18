import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/extensions.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/features/main/main_category/view_model/main_category_view_model.dart';
import 'package:todo_infinity_app/features/task/view_model/task_view_model.dart';
import 'package:todo_infinity_app/features/task/views/widgets/task_single_text_field.dart';
import 'package:todo_infinity_app/features/task/views/widgets/todo_category.dart';

import '../../../../../core/styles/text_styles.dart';
import '../widgets/task_note_unactiove.dart';

class TaskSinglePage extends StatefulWidget {
  const TaskSinglePage({super.key});

  @override
  State<TaskSinglePage> createState() => _TaskSinglePageState();
}

class _TaskSinglePageState extends State<TaskSinglePage> {
  final TaskViewModel taskVM = Get.find<TaskViewModel>();
  final MainCategoryViewModel categoryVM = Get.find<MainCategoryViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: AppBar(
          title: Text(taskVM.isEditing.value ? PersianStrings.editTask: PersianStrings.newTask,
              style: AppTextStyles.titleOfAppBar),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              taskVM.clearSingleTodoAfterAdd();
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
                TaskSinglePageTextField(
                  controller: taskVM.todoEditingController,
                  categoryModel: taskVM.model.categoryModel,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return PersianStrings.requiredText;
                    }
                    return null;
                  },
                ),
                (AppDimens.medium * 2).height,
                Obx(
                  () => taskVM.isActiveNote.value
                      ? TaskSinglePageTextField(
                          controller: taskVM.descEditingController,
                          categoryModel: taskVM.model.categoryModel,
                          onChanged: (value) {
                            taskVM.model.description(value);
                          },
                          validator: (value) {
                            return null;
                          },
                          icon: GestureDetector(
                            onTap: () => taskVM.isActiveNote(false),
                            child: const Icon(Icons.close),
                          ),
                        )
                          .animate(delay: const Duration(milliseconds: 250))
                          .fade()
                      : TaskNoteUnActive(),
                ),
                (AppDimens.medium * 2).height,
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'دسته بندی :',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                Gap(AppDimens.high),
                Align(
                  alignment: Alignment.centerRight,
                  child: TaskSinglePageCategory(
                    title: taskVM.model.categoryModel.title,
                    bgColor: colorList[taskVM.model.categoryModel.colorIndex],
                    isEmpty: taskVM.model.categoryModel.title.isEmpty.obs,
                    icon: iconList[taskVM.model.categoryModel.iconIndex].image,
                    onTap: () {
                      //taskCategoryBottomSheet(context);
                    },
                  ),
                ),
                Gap(AppDimens.high),
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
            if(taskVM.isEditing.value){
              taskVM.updateTodo();
            }
            else {
              taskVM.addTodo();
            }
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
        child: Text(
          taskVM.isEditing.value ? PersianStrings.edit :
          PersianStrings.add,
        ),
      ),
    );
  }
}
