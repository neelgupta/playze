import 'package:get/get.dart';

import '../controllers/place_full_details_controller.dart';

class PlaceFullDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceFullDetailsController>(
      () => PlaceFullDetailsController(),
    );
  }
}
