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

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightColors.primaryBG,
        body: Stack(
          children: [
            const TopSection(),
            BottomSection(),
          ],
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  BottomSection({Key? key}) : super(key: key);
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passText = TextEditingController();
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
        height: Dimens.height / 1.5,
        decoration: AppBoxDecoration.whiteRadius,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              PersianStrings.welcomeBack,
              style: LightTextStyles.bigTitle,
            ),
            Dimens.small.height,
            Text(
              PersianStrings.enterYourDetailsBelow,
              style: LightTextStyles.normall12(LightColors.greyText),
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
            Container(
              margin: EdgeInsets.all(Dimens.high),
              width: Dimens.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  processSignIn(context);
                },
                child: const Text(PersianStrings.signin),
              ),
            ),
          ],
        ),
      ),
    );
  }

  processSignIn(BuildContext context) {
    _emailText.text.isEmpty
        ? _validateEmail.value = true
        : _validateEmail.value = false;
    _passText.text.isEmpty
        ? _validatePass.value = true
        : _validatePass.value = false;

    if (_validateEmail.value == false && _validatePass.value == false) {
      if (_isEmail.value == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(PersianStrings.emailIsNotTrue),
            backgroundColor: LightColors.primaryBG,
          ),
        );
      }
      else {
        RegisterController controller = Get.find<RegisterController>();
        String email = _emailText.text;
        String password = _passText.text;
        controller.signInUser( email, password);
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
              Text(
                PersianStrings.dontHaveAnAccount,
                style: LightTextStyles.normall12(LightColors.white54Text),
              ),
              Dimens.small.width,
              TextButton(
                onPressed: () {
                  Get.toNamed(PageName.registerPage);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white24),
                ),
                child: const Text(
                  PersianStrings.getStarted,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),
          (Dimens.high * 4).height,
          Text(
            PersianStrings.doIt,
            style: LightTextStyles.bold28Fanavari(LightColors.whiteText),
          ),
        ],
      ),
    );
  }
}
