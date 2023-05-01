import 'package:get/get.dart';
import 'package:playze/app/routes/app_pages.dart';

class FristpageController extends GetxController {
  //TODO: Implement FristpageController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 4)).then((value) {
      Get.offAndToNamed(Routes.SIGNIN);
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

  void increment() => count.value++;
}
