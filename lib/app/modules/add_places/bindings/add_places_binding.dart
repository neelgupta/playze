import 'package:get/get.dart';

import '../controllers/add_places_controller.dart';

class AddPlacesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPlacesController>(
      () => AddPlacesController(),
    );
  }
}
