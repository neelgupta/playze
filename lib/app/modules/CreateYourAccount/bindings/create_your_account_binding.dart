import 'package:get/get.dart';

import '../controllers/create_your_account_controller.dart';

class CreateYourAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateYourAccountController>(
      () => CreateYourAccountController(),
    );
  }
}
