import 'package:get/get.dart';

class ReviewImagesController extends GetxController {
  //TODO: Implement ReviewImagesController

  final count = 0.obs;

  var args = Get.arguments;

  var imageUrl  ="";

  @override
  void onInit() {
    super.onInit();

    imageUrl =  args[0];

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
