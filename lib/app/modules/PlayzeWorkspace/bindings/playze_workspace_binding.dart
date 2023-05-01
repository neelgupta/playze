import 'package:get/get.dart';

import '../controllers/playze_workspace_controller.dart';

class PlayzeWorkspaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayzeWorkspaceController>(
      () => PlayzeWorkspaceController(),
    );
  }
}
