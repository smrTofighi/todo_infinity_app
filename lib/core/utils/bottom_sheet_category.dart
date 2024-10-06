import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/core/widgets/loading.dart';
import 'package:todo_infinity_app/features/auth/views/widgets/custom_textfield.dart';
import 'package:todo_infinity_app/features/main/main_category/view_model/main_category_view_model.dart';
import '../widgets/main_category/color_widget.dart';

void bottomSheetCategory(
  String title,
  TextEditingController controller,
  Function() confirmTap,
  Function() closeTap,
  BuildContext context,
) {
  final categoryVM = Get.find<MainCategoryViewModel>();
  RxBool emailValidate = false.obs;
  final RxInt colorIndex = 0.obs;
  final RxInt iconIndex = 0.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      width: AppDimens.sizeOfDevice(context).width,
      height: AppDimens.sizeOfDevice(context).height / 2.2,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Theme.of(context).cardColor,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: LightTextStyles.titleOfBottomSheet,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: CustomTextField(
                  controller: _categoryController,
                  hint: 'دسته بندی',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return PersianStrings.requiredText;
                    }
                    return null;
                  },
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              height: 45,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: iconList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Obx(
                    () => IconWidget(
                      colorIndex: colorIndex.value,
                      iconIndex: iconIndex.value,
                      index: index,
                      onTap: () {
                        iconIndex(index);
                      },
                    ),
                  );
                },
              ),
            ),
            Gap(AppDimens.high),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              height: 34,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: colorList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Obx(
                  () => ColorWidget(
                      color: index == colorIndex.value
                          ? colorList[index]
                          : colorList[index].withOpacity(0.45),
                      onTap: () {
                        colorIndex(index);
                      }),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(
              () => categoryVM.isLoadingBottomSheet.value
                  ? const Center(
                    child: Loading(
                        color: LightColors.primary,
                        size: 42,
                      ),
                  )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 35,
                          width: AppDimens.sizeOfDevice(context).width / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              categoryVM.addCategory(
                                title: _categoryController.text,
                                iconIndex: iconIndex.value,
                                colorIndex: colorIndex.value,
                                context: context,
                              );
                            },
                            child: const Text(PersianStrings.add),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 35,
                          width: AppDimens.sizeOfDevice(context).width / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              emailValidate(false);
                              closeTap();
                            },
                            child: const Text(PersianStrings.cancel),
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    isDismissible: false,
  );
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.iconIndex,
    required this.colorIndex,
    required this.index,
    required this.onTap,
  });

  final int index;

  final int iconIndex;
  final int colorIndex;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 45,
        height: 45,
        padding: EdgeInsets.all(AppDimens.small / 1.2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radius),
            border: Border.all(
                color: index == iconIndex
                    ? colorList[colorIndex]
                    : Colors.transparent,
                width: 2)),
        curve: Curves.easeInOutQuint,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        duration: const Duration(milliseconds: 350),
        child: ImageIcon(
          iconList[index].image,
          size: 32,
          color: index == iconIndex ? colorList[colorIndex] : Colors.grey,
        ),
      ),
    );
  }
}
