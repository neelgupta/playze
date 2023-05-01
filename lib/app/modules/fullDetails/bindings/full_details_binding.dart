import 'package:get/get.dart';

import '../controllers/full_details_controller.dart';

class FullDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FullDetailsController>(
      () => FullDetailsController(),
    );
  }
}
