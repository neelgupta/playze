import 'dart:developer';

import 'package:get/get.dart';
import 'package:playze/app/modules/home/controllers/home_controller.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../../../../reusability/utils/shared_prefs.dart';
import '../../../data/service/user_service.dart';

class BottomNavigationBarController extends GetxController {
  final count = 0.obs;

  var args = Get.arguments;
  var locateWindowPop = false.obs;
  var selectedIndex = 0.obs;
  get getSelectedIndex => selectedIndex.value;
  set setSelectedIndex(value) => selectedIndex.value = value;

  UserService userService = UserService();

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  Future<void> addTowishListFunction({placeId}) async {
    if (Get.isRegistered<HomeController>()) {
      var homeController = Get.find<HomeController>();
      try {
        var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

        homeController.isLoading(true);
        locateWindowPop(false);
        await userService
            .addToWishListMethod(
          userId: userId,
          placeId: placeId,
          status: 1,
        )
            .then((value) {
          if (value!) {
            homeController.getPlacesList();
          }
        });

        // isLoading(false);
        update();
      } catch (e) {
        log(e.toString());
      } finally {
        // isLoading(false);
      }
    }
  }

  Future<void> removeFromWishListFunction({placeId}) async {
    if (Get.isRegistered<HomeController>()) {
      var homeController = Get.find<HomeController>();
      try {
        var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

        homeController.isLoading(true);
        locateWindowPop(false);
        await userService
            .addToWishListMethod(
          userId: userId,
          placeId: placeId,
          status: 0,
        )
            .then((value) {
          if (value! == true) {
            homeController.getPlacesList();
          }
        });

        // isLoading(false);
        update();
      } catch (e) {
        log(e.toString());
      } finally {
        // isLoading(false);
      }
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      log("selectedIndex $selectedIndex");
      selectedIndex.value = args[0];
    } else {
      log("selectedIndex $selectedIndex");
      selectedIndex = 0.obs;
    }
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
  onOtherScreen(int index) {
    selectedIndex.value = index;
    log("selectedIndex.value : ${selectedIndex.value}");
    Get.offNamedUntil(Routes.BOTTOM_NAVIGATIONBAR, (route) => false,
        arguments: [index]);
  }
}
