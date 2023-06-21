import 'dart:developer';

import 'package:get/get.dart';
import 'package:playze/app/routes/app_pages.dart';

class BottomNavigationBarController extends GetxController {
  final count = 0.obs;

  var args = Get.arguments;
  var locateWindowPop = false.obs;
  var selectedIndex = 0.obs;
  get getSelectedIndex => selectedIndex.value;
  set setSelectedIndex(value) => selectedIndex.value = value;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      log("selectedIndex $selectedIndex");
      selectedIndex.value = args[0];
    } else {
      log("selectedIndex $selectedIndex");
      selectedIndex = 0.obs;
    }
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
  onOtherScreen(int index) {
    selectedIndex.value = index;
    log("selectedIndex.value : ${selectedIndex.value}");
    Get.offNamedUntil(Routes.BOTTOM_NAVIGATIONBAR, (route) => false,
        arguments: [index]);
  }
}
