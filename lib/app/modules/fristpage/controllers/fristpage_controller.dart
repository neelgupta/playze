import 'package:get/get.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/routes/app_pages.dart';

class FristpageController extends GetxController {
  //TODO: Implement FristpageController

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 4)).then((value) async {
      bool loginstatus = SharedPrefs().value.read(SharedPrefs.setBool) ?? false;
      SharedPrefs().value.read(SharedPrefs.setBool);
      print("====>$loginstatus");
      loginstatus?
      Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR):Get.offAndToNamed(Routes.SIGNIN);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Future.delayed(Duration(seconds: 4)).then((value) {
  // Get.offAndToNamed(Routes.SIGNIN);
  // });

  // Future.delayed(Duration(seconds: 4)).then((value) async {
  // bool loginstatus = SharedPrefs().value.read(SharedPrefs.setBool) ?? false;
  // SharedPrefs().value.read(SharedPrefs.setBool);
  // print("====>$loginstatus");
  // loginstatus?
  // Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR):Get.offAndToNamed(Routes.SIGNIN);
  // });
}
