import 'package:get/get.dart';

class ReviewImagesController extends GetxController {
  final count = 0.obs;

  var args = Get.arguments;

  bool isNetwork = true;

  var imageUrl = "";

  @override
  void onInit() {
    super.onInit();

    imageUrl = args[0];

    var arguments = args as List;
    if (arguments.length > 1) {
      isNetwork = args[1];
    }
  }

  void increment() => count.value++;
}
