import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_infinity_app/controllers/task_controller.dart';
import 'package:todo_infinity_app/core/values/dimens.dart';
import 'package:todo_infinity_app/core/values/icons.dart';
import 'package:todo_infinity_app/core/values/strings.dart';
import 'package:todo_infinity_app/models/category_model.dart';
import 'package:todo_infinity_app/routes/pages.dart';
import 'package:todo_infinity_app/views/pages/category/widgets/color_widget.dart';
import '../core/values/colors.dart';
import '../core/values/storages.dart';

class CategoryController extends GetxController {
  //? A list of categories
  RxList<CategoryModel> categoryList = RxList();
  //? text editing controller for category name
  TextEditingController textEditingCategory = TextEditingController();
  RxInt colorIndex = 0.obs;
  RxInt iconIndex = 0.obs;
  RxInt allCountItemsCategories = 0.obs;
  RxInt completeCountItemsCategories = 0.obs;
  RxBool isEditing = false.obs;

  //? static variables
  List<ImageProvider> iconList = [
    MyIcons.tree,
    MyIcons.bed,
    MyIcons.book,
    MyIcons.books,
    MyIcons.bulb,
    MyIcons.cake,
    MyIcons.car,
    MyIcons.dollar,
    MyIcons.dream,
    MyIcons.football,
    MyIcons.gift,
    MyIcons.glassCheers,
    MyIcons.gym,
    MyIcons.moon,
    MyIcons.music,
    MyIcons.handHoldingHeart,
    MyIcons.home,
    MyIcons.volleyball,
    MyIcons.note,
    MyIcons.plane,
    MyIcons.school,
    MyIcons.shop,
    MyIcons.sunrise,
    MyIcons.work,
    MyIcons.world,
  ];
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.purple,
    Colors.amber,
    Colors.cyan,
    Colors.lime,
    Colors.pink,
    Colors.teal,
    Colors.blueGrey,
    Colors.indigo,
    Colors.lightGreen
  ];

  //? onInit function
  @override
  void onInit() {
    super.onInit();
    countAllItemsCategories();
  }

  //? this method delete your category
  deleteCateogry(int index, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    if (index != 0) {
      Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: SolidColors.card,
        buttonColor: SolidColors.primary,
        confirm: Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          height: 30,
          width: width / 4,
          child: ElevatedButton(
            onPressed: () {
              Get.back();
              categoryList.removeAt(index);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.redAccent),
            ),
            child: const Text(MyStrings.delete),
          ),
        ),
        cancel: Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          height: 30,
          width: width / 4,
          child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            child: const Text(MyStrings.cancel),
          ),
        ),
        onConfirm: () {
          categoryList.removeAt(index);
        },
        title: '',
        titleStyle: const TextStyle(fontSize: 10),
        titlePadding: const EdgeInsets.all(0),
        middleText: 'دسته بندی ${categoryList[index].name} حذف شود؟',
        radius: Dimens.radius,
      );
    }
  }

  //? Toast Message
  toastMessage(String message, BuildContext context) {
    toastification.showSuccess(
      context: context,
      title: message,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  //? we can edit name, logo and color of our category
  editCategoryWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          width: width,
          height: height / 2.2,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: SolidColors.card),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  MyStrings.editCategory,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  controller: textEditingCategory,
                  cursorColor: SolidColors.primary,
                  maxLength: 20,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: MyStrings.nameOfCategory,
                  ),
                ),
              ),
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
                      () => GestureDetector(
                        onTap: () {
                          iconIndex.value = index;
                        },
                        child: AnimatedContainer(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          duration: const Duration(seconds: 1),
                          child: ImageIcon(
                            size: 35,
                            iconList[index],
                            color: index == iconIndex.value
                                ? colorList[colorIndex.value]
                                : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
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
                        colorIndex.value = index;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 35,
                    width: width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        isEditing.value = true;
                        checkInputsForCategory(
                            context, 'نام دسته بندی خالی است!');
                      },
                      child: const Text(MyStrings.edit),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 35,
                    width: width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        clearInputs();
                      },
                      child: const Text(MyStrings.cancel),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        isDismissible: false);
  }

  changeThemeCategory(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          width: width,
          height: height / 3.8,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: SolidColors.card,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  MyStrings.changeColorOfCategory,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                height: 34,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: colorList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Obx(
                    () => ColorWidget(
                      color: index == colorIndex.value
                          ? colorList[index]
                          : colorList[index].withOpacity(0.45),
                      onTap: () {
                        colorIndex.value = index;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 35,
                    width: width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        TaskController taskController =
                            Get.find<TaskController>();
                        taskController.categoryModel.value.color =
                            colorList[colorIndex.value];
                        Get.offAllNamed(PageName.categoryPage);
                        colorIndex.value = 0;
                      },
                      child: const Text(MyStrings.edit),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 35,
                    width: width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        colorIndex.value = 0;
                        Get.back();
                      },
                      child: const Text(MyStrings.edit),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        isDismissible: false);
  }

  checkInputsForCategory(BuildContext context, String title) {
    if (textEditingCategory.text == '') {
      toastification.showError(
        context: context,
        title: title,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else {
      isEditing.value ? editCategory() : addCategory();
    }
  }

  deleteAllTaskCategories(BuildContext context) {
    for (var category in categoryList) {
      if (category.allTaskList!.isNotEmpty) {
        category.allTaskList!.clear();
      }
    }
    toastMessage('موفقیت آمیز بود', context);
    countAllItemsCategories();
    Get.offAllNamed(PageName.categoryPage);
  }

  clearInputs() {
    isEditing.value = false;
    colorIndex.value = 0;
    iconIndex.value = 0;
    textEditingCategory.text = '';
  }

  editCategory() {
    TaskController taskController = Get.find<TaskController>();
    taskController.categoryModel.update((val) {
      val!.name = textEditingCategory.text;
      val.color = colorList[colorIndex.value];
      val.icon = iconList[iconIndex.value];
    });
    Get.offAllNamed(PageName.categoryPage);

    clearInputs();
  }

  changeThemeMainCategory(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        width: width,
        height: height / 3.8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: SolidColors.card,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                MyStrings.changeColorOfCategory,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
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
                      colorIndex.value = index;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 35,
                  width: width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      categoryList[0].color = colorList[colorIndex.value];
                      Get.offAllNamed(PageName.categoryPage);
                      clearInputs();
                    },
                    child: const Text(MyStrings.edit),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 35,
                  width: width / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      clearInputs();
                      Get.back();
                    },
                    child: const Text(MyStrings.cancel),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  countAllItemsCategories() {
    allCountItemsCategories.value = 0;
    completeCountItemsCategories.value = 0;
    for (var category in categoryList) {
      allCountItemsCategories.value += category.allTaskList!.length;
      completeCountItemsCategories.value += category.completeTaskList!.length;
    }
  }

  addCategory() {
    Get.back();
    categoryList.add(
      CategoryModel(
        name: textEditingCategory.text,
        icon: iconList[iconIndex.value],
        color: colorList[colorIndex.value],
        allTaskList: [],
        completeTaskList: [],
        lastTaskList: [],
      ),
    );

    clearInputs();
  }

  addCategoryWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          width: width,
          height: height / 2.2,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: SolidColors.card),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  MyStrings.newCategory,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  controller: textEditingCategory,
                  cursorColor: SolidColors.primary,
                  maxLength: 20,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'نام دسته بندی',
                  ),
                ),
              ),
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
                      () => GestureDetector(
                        onTap: () {
                          iconIndex.value = index;
                        },
                        child: AnimatedContainer(
                          width: 30,
                          height: 30,
                          curve: Curves.easeInOutQuint,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          duration: const Duration(seconds: 1),
                          child: ImageIcon(
                            size: 35,
                            iconList[index],
                            color: index == iconIndex.value
                                ? colorList[colorIndex.value]
                                : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
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
                        colorIndex.value = index;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 35,
                    width: width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        addCategory();
                      },
                      child: const Text(MyStrings.add),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 35,
                    width: width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        colorIndex.value = 0;
                        iconIndex.value = 0;
                        textEditingCategory.text = '';
                      },
                      child: const Text(MyStrings.cancel),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        isDismissible: false);
  }

  Future firstSeen() async {
    final box = GetStorage();
    var seen = (box.read(StorageKey.seen) ?? false);
    if (seen) {
      categoryList.add(
        CategoryModel(
          name: MyStrings.all,
          icon: MyIcons.noteBook,
          color: SolidColors.primary,
          allTaskList: [],
          completeTaskList: [],
          lastTaskList: [],
        ),
      );
      Get.offNamed(PageName.categoryPage);
    } else {
      box.write(StorageKey.seen, true);
      categoryList.add(
        CategoryModel(
          name: MyStrings.all,
          icon: MyIcons.noteBook,
          color: SolidColors.primary,
          allTaskList: [],
          completeTaskList: [],
          lastTaskList: [],
        ),
      );
      Get.offNamed(PageName.categoryPage);
    }
  }
}
