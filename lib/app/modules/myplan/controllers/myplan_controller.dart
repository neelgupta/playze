import 'package:get/get.dart';

class MyplanController extends GetxController {
  //TODO: Implement MyplanController

  final count = 0.obs;
  final List<int> items = List<int>.generate(5, (int index) => index);
  @override
  void onInit() {
    super.onInit();
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
