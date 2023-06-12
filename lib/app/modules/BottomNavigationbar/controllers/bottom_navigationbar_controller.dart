import 'package:get/get.dart';
import 'package:playze/app/routes/app_pages.dart';

class BottomNavigationbarController extends GetxController {
  //TODO: Implement BottomNavigationbarController

  final count = 0.obs;

  var args = Get.arguments;
  var locateWindowPop = false.obs;
  var _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(value) => _selectedIndex.value = value;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      print(_selectedIndex);
      _selectedIndex.value = args[0];
    } else {
      print(_selectedIndex);
      _selectedIndex = 0.obs;
    }
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
  onOtherScreen(int index) {
    selectedIndex = index;
    print(selectedIndex);
    Get.offNamedUntil(Routes.BOTTOM_NAVIGATIONBAR, (route) => false,
        arguments: [index]);
  }
}
