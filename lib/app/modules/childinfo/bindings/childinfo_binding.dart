import 'package:get/get.dart';

import '../controllers/childinfo_controller.dart';

class ChildinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChildinfoController>(
      () => ChildinfoController(),
    );
  }
}
