import 'package:get/get.dart';

import '../controllers/myplan_controller.dart';

class MyplanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyplanController>(
      () => MyplanController(),
    );
  }
}
