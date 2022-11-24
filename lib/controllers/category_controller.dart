import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/models/category_model.dart';
import 'package:todo_infinity_app/routes/pages.dart';

import '../core/values/storages.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categoryList = RxList();

  Future firstSeen() async {
    final box = GetStorage();
    var seen = (box.read(StorageKey.seen) ?? false);
    if (seen) {
      Get.offNamed(PageName.categoryPage);
    } else {
      box.write(StorageKey.seen, true);
      categoryList.add(
        CategoryModel(
          name: MyStrings.all,
          icon: MyIcons.noteBook,
          taskList: [],
        ),
      );
      Get.offNamed(PageName.categoryPage);
    }
  }
}
