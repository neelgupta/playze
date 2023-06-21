import 'dart:developer';

import 'package:get/get.dart';
import 'package:playze/reusability/utils/shared_prefs.dart';
import 'package:playze/app/routes/app_pages.dart';

class FirstPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 4)).then(
      (value) async {
        bool loginstatus =
            SharedPrefs().value.read(SharedPrefs.setBool) ?? false;
        SharedPrefs().value.read(SharedPrefs.setBool);
        log("====>$loginstatus");
        loginstatus
            ? Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR)
            : Get.offAndToNamed(Routes.SIGNIN);
      },
    );
  }
}
