import 'package:get/get.dart';

import '../controllers/add_profile_picture_controller.dart';

class AddProfilePictureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProfilePictureController>(
      () => AddProfilePictureController(),
    );
  }
}
