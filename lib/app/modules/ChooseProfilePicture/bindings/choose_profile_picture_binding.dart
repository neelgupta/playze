import 'package:get/get.dart';

import '../controllers/choose_profile_picture_controller.dart';

class ChooseProfilePictureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseProfilePictureController>(
      () => ChooseProfilePictureController(),
    );
  }
}
