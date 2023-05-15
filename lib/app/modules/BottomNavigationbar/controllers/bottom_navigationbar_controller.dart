import 'package:get/get.dart';
import 'package:playze/app/modules/myplan/views/myplan_view.dart';
import 'package:playze/app/modules/profile/views/profile_view.dart';
import 'package:playze/app/modules/wishlist/views/wishlist_view.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../../home/views/home_view.dart';

class BottomNavigationbarController extends GetxController {
  //TODO: Implement BottomNavigationbarController

  final count = 0.obs;

  var args = Get.arguments;
  var Dpop = false.obs;
  var _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(value) => _selectedIndex.value = value;

  @override
  void changeTabIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  void onInit() {
    if (Get.arguments != null) {
      print(_selectedIndex);
      _selectedIndex.value = args[0];
    } else {
      print(_selectedIndex);
      _selectedIndex = 0.obs;
    }
  }

  @override
  void onReady() {

  }

  @override
  void onClose() {

  }
  onOtherScreen(int index) {
    selectedIndex = index;
    print(selectedIndex);
    Get.offNamedUntil(Routes.BOTTOM_NAVIGATIONBAR, (route) => false, arguments: [index]);
  }

}
