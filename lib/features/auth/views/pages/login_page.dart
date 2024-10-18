import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/routes/pages.dart';
import 'package:todo_infinity_app/core/styles/box_decoration.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/features/auth/views/widgets/auth_tile.dart';
import 'package:todo_infinity_app/features/main/widgets/loading.dart';
import 'package:todo_infinity_app/features/auth/view_model/auth_view_model.dart';
import 'package:todo_infinity_app/features/auth/views/widgets/auth_top_section.dart';
import 'package:todo_infinity_app/features/auth/views/widgets/custom_textfield.dart';
import 'package:validators/validators.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBG,
        body: Stack(
          children: [
            AuthTopSection(
              message: PersianStrings.dontHaveAnAccount,
              btnText: PersianStrings.signup,
              onTap: () => Get.offNamed(PageName.signUp),
            ),
            BottomSection(),
          ],
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  BottomSection({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthViewModel authVM = Get.find<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: AppDimens.width,
        height: AppDimens.height / 1.5,
        decoration: AppBoxDecoration.whiteRadius,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AuthTile(
                title: PersianStrings.welcomeBack,
                subtitle: PersianStrings.enterYourDetailsBelow,
              ),
              Gap(AppDimens.medium),
              CustomTextField(
                controller: _emailController,
                hint: 'ایمیل',
                validator: (val) {
                  if (val!.isEmpty) {
                    return PersianStrings.requiredText;
                  } else if (!isEmail(val)) {
                    return PersianStrings.emailFormatIsNotTrue;
                  }
                  return null;
                },
              ),
              Gap(AppDimens.medium),
              CustomTextField(
                controller: _passwordController,
                hint: 'رمز عبور',
                validator: (val) {
                  if (val!.isEmpty) {
                    return PersianStrings.requiredText;
                  }
                  return null;
                },
                type: TextInputType.visiblePassword,
              ),
              Container(
                margin: EdgeInsets.all(AppDimens.high),
                width: AppDimens.infinity,
                height: 45,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: authVM.isLoading.value
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              authVM.logInUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                                context: context,
                              );
                            }
                          },
                    child: authVM.isLoading.value
                        ? const Loading(
                            color: Colors.white,
                            size: 24,
                          )
                        : const Text(PersianStrings.signin),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}