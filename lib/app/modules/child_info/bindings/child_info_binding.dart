import 'package:get/get.dart';

import '../controllers/child_info_controller.dart';

class ChildInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChildInfoController>(
      () => ChildInfoController(),
    );
  }
}
