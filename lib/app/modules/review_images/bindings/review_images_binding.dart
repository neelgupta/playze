import 'package:get/get.dart';

import '../controllers/review_images_controller.dart';

class ReviewImagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewImagesController>(
      () => ReviewImagesController(),
    );
  }
}
