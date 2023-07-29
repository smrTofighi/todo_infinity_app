import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_infinity_app/core/styles/extensions.dart';
import 'package:todo_infinity_app/core/styles/box_decoration.dart';
import 'package:todo_infinity_app/core/styles/text_styles.dart';
import 'package:todo_infinity_app/core/values/colors.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/modules/register/register_controller.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:validators/validators.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightColors.primaryBG,
        body: Stack(
          children: [
            BottomSection(),
            const TopSection(),
          ],
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  BottomSection({Key? key}) : super(key: key);
  final TextEditingController _nameText = TextEditingController();
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passText = TextEditingController();
  final TextEditingController _repPassText = TextEditingController();
  final RxBool _validateName = false.obs;
  final RxBool _validateEmail = false.obs;
  final RxBool _validatePass = false.obs;
  final RxBool _isEmail = false.obs;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: Dimens.width,
        height: Dimens.height * 0.75,
        decoration: AppBoxDecoration.whiteRadius,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              PersianStrings.getStartedFree,
              style: LightTextStyles.bigTitle,
            ),
            Dimens.small.height,
            Text(
              PersianStrings.freeForeverNoCostNeeded,
              style: LightTextStyles.normall12(LightColors.greyText),
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(Dimens.high, Dimens.high, Dimens.high, 0),
              child: Obx(
                () => TextField(
                  controller: _nameText,
                  style: LightTextStyles.normall12(LightColors.blackText),
                  decoration: InputDecoration(
                    hintText: PersianStrings.name,
                    errorText: _validateName.value
                        ? PersianStrings.nameCanNotIsEmpty
                        : null,
                    errorStyle: LightTextStyles.normal10(LightColors.redText),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimens.high),
              child: Obx(
                () => TextField(
                  controller: _emailText,
                  onChanged: (value) {
                    _isEmail.value = isEmail(value);
                  },
                  style: LightTextStyles.normall12(LightColors.blackText),
                  decoration: InputDecoration(
                    hintText: PersianStrings.email,
                    errorText: _validateEmail.value
                        ? PersianStrings.emailCanNotIsEmpty
                        : null,
                    errorStyle: LightTextStyles.normal10(LightColors.redText),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.high),
              child: Obx(
                () => TextField(
                  controller: _passText,
                  style: LightTextStyles.normall12(LightColors.blackText),
                  decoration: InputDecoration(
                    hintText: PersianStrings.password,
                    errorText: _validatePass.value
                        ? PersianStrings.passwordCanNotIsEmpty
                        : null,
                    errorStyle: LightTextStyles.normal10(LightColors.redText),
                  ),
                ),
              ),
            ),
            Dimens.high.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.high),
              child: Obx(
                () => TextField(
                  controller: _repPassText,
                  style: LightTextStyles.normall12(LightColors.blackText),
                  decoration: InputDecoration(
                    hintText: PersianStrings.repeatPassword,
                    errorText: _validatePass.value
                        ? PersianStrings.passwordCanNotIsEmpty
                        : null,
                    errorStyle: LightTextStyles.normal10(LightColors.redText),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(Dimens.high),
              width: Dimens.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  processRegister(context);
                },
                child: const Text(PersianStrings.signup),
              ),
            ),
          ],
        ),
      ),
    );
  }

  processRegister(BuildContext context) {
  
    _emailText.text.isEmpty
        ? _validateEmail.value = true
        : _validateEmail.value = false;
    _passText.text.isEmpty
        ? _validatePass.value = true
        : _validatePass.value = false;
    _nameText.text.isEmpty
        ? _validateName.value = true
        : _validateName.value = false;

    if (_validateEmail.value == false &&
        _validatePass.value == false &&
        _validateName.value == false) {
      if (_isEmail.value == false && _emailText.text.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(PersianStrings.emailIsNotTrue),
            backgroundColor: LightColors.primaryBG,
          ),
        );
      } else {
        RegisterController controller = Get.find<RegisterController>();
        String name = _nameText.text;
        String email = _emailText.text;
        String password = _passText.text;
        String rePassword = _repPassText.text;
        controller.registerUser(name, email, password, rePassword);
      }
    }
  }
}

class TopSection extends StatelessWidget {
  const TopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          (Dimens.high * 2).height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                PersianStrings.alreadyHaveAnAccount,
                style: TextStyle(fontSize: 12, color: Colors.white54),
              ),
              Dimens.small.width,
              TextButton(
                onPressed: () {
                  Get.toNamed(PageName.signInPage);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white24),
                ),
                child: Text(
                  PersianStrings.signin,
                  style: LightTextStyles.normall12(LightColors.whiteText),
                ),
              )
            ],
          ),
          (Dimens.high * 2).height,
          Text(
            PersianStrings.doIt,
            style: LightTextStyles.bold28Fanavari(LightColors.whiteText),
          ),
        ],
      ),
    );
  }
}
