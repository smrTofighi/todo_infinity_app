import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_infinity_app/core/utils/api_constant.dart';
import 'package:todo_infinity_app/core/utils/api_key.dart';
import 'package:todo_infinity_app/core/utils/storage_key.dart';
import 'package:todo_infinity_app/data/services/dio_service.dart';
import 'package:todo_infinity_app/routes/pages.dart';

class RegisterController extends GetxController {
  checkUserSignIn() async{
    final box = GetStorage();
    if (await box.read(StorageKeys.token) != null) {
      Get.offNamed(PageName.mainPage);
    } else {
      Get.offNamed(PageName.signInPage);
    }
  
  }

  registerUser(
      String name, String email, String password, String rePassword) async {
    var url = ApiConstant.registerApi(name, email, password, rePassword);

    var response = await DioService().postMethod(url);

    if (response.data[ApiKey.success] == true) {
      String token = response.data[ApiKey.data][ApiKey.token];

      GetStorage().write(StorageKeys.token, token);
      Get.offAllNamed(PageName.mainPage);
    }
  }

  signInUser(String email, String password) async {
    var url = ApiConstant.signInApi(email, password);
    var response = await DioService().postMethod(url);
    if (response.data[ApiKey.success] == true) {
      String token = response.data[ApiKey.data][ApiKey.token];

      GetStorage().write(StorageKeys.token, token);
      Get.offAllNamed(PageName.mainPage);
      log(token);
    }
  }
}
