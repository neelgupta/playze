import 'package:get/get.dart';

import '../controllers/review_videos_controller.dart';

class ReviewVideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewVideosController>(
      () => ReviewVideosController(),
    );
  }
}
