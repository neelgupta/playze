import 'package:get/get.dart';

import '../controllers/addplaces_controller.dart';

class AddplacesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddplacesController>(
      () => AddplacesController(),
    );
  }
}
