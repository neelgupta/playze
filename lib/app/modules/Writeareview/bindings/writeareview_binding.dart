import 'package:get/get.dart';

import '../controllers/writeareview_controller.dart';

class WriteareviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WriteareviewController>(
      () => WriteareviewController(),
    );
  }
}
