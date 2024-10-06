import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/routes/pages.dart';
import 'package:todo_infinity_app/core/styles/extensions.dart';
import 'package:todo_infinity_app/core/styles/box_decoration.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/core/widgets/loading.dart';
import 'package:todo_infinity_app/features/auth/view_model/auth_view_model.dart';
import 'package:todo_infinity_app/features/auth/views/pages/login_page.dart';
import 'package:todo_infinity_app/features/auth/views/widgets/auth_top_section.dart';
import 'package:todo_infinity_app/features/auth/views/widgets/custom_textfield.dart';

import 'package:validators/validators.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightColors.primaryBG,
        body: Stack(
          children: [
            BottomSection(),
            AuthTopSection(
              message: PersianStrings.alreadyHaveAnAccount,
              btnText: PersianStrings.signin,
              onTap: () => Get.offNamed(PageName.logIn),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  BottomSection({super.key});
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthViewModel authVM = Get.find<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: AppDimens.width,
        height: AppDimens.height * 0.75,
        decoration: AppBoxDecoration.whiteRadius,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AuthTile(
                title: PersianStrings.getStartedFree,
                subtitle: PersianStrings.freeForeverNoCostNeeded,
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
              Gap(AppDimens.medium),
              AppDimens.high.height,
              CustomTextField(
                controller: _firstNameController,
                hint: 'نام',
                validator: (val) {
                  if (val!.isEmpty) {
                    return PersianStrings.requiredText;
                  }
                  return null;
                },
              ),
              Gap(AppDimens.medium),
              CustomTextField(
                controller: _lastNameController,
                hint: 'نام خانوادگی',
                validator: (val) {
                  if (val!.isEmpty) {
                    return PersianStrings.requiredText;
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.all(AppDimens.high),
                width: AppDimens.infinity,
                height: 45,
                child: Obx(
                  () =>  ElevatedButton(
                    onPressed: authVM.isLoading.value ? null : () {
                      if (_formKey.currentState!.validate()) {
                        authVM.signUpUser(
                          email: _emailController.text,
                          password: _passwordController.text,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          context: context
                        );
                      }
                    },
                    child:  authVM.isLoading.value
                          ? const Loading(color: Colors.white, size: 24,)
                          : const Text(PersianStrings.signup),
                    
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
