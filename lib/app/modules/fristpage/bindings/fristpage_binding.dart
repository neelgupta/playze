import 'package:get/get.dart';

import '../controllers/fristpage_controller.dart';

class FristpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FristpageController>(
      () => FristpageController(),
    );
  }
}
