import 'package:get/get.dart';
import 'package:playze/app/modules/myplan/controllers/myplan_controller.dart';
import 'package:playze/app/modules/wishlist/controllers/wishlist_controller.dart';

import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/bottom_navigation_bar_controller.dart';

class BottomNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationBarController>(
      () => BottomNavigationBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<WishlistController>(
      () => WishlistController(),
    );
    Get.lazyPut<MyplanController>(
      () => MyplanController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
