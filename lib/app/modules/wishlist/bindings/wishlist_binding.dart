import 'package:get/get.dart';

import '../../BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';
import '../controllers/wishlist_controller.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistController>(
      () => WishlistController(),
    );
    Get.lazyPut<BottomNavigationbarController>(
          () => BottomNavigationbarController(),
    );
  }
}
