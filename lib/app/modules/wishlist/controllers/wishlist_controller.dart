import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../reusability/utils/shared_prefs.dart';
import '../../../data/modal/place_data_model.dart';
import '../../../data/modal/wishlist_get_model.dart';
import '../../../data/service/plan_service.dart';
import '../../../data/service/user_service.dart';
import '../../bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../myplan/controllers/myplan_controller.dart';

class WishlistController extends GetxController {
  final count = 0.obs;

  final isLoading = false.obs;
  UserService userService = UserService();

  WishListGetModel? wishListGetModel;
  List<WishListData> wishDataList = [];

  void increment() => count.value++;

  Future<void> getWishListFunction() async {
    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isLoading(true);
      await userService
          .wishListGetMethod(
        userId: userId,
      )
          .then((value) {
        wishListGetModel = value;
        if (wishListGetModel != null) {
          wishDataList.clear();
          for (var element in wishListGetModel!.data) {
            wishDataList.add(element);
            // lip.add(element.name);
          }
          log("wishDataList len is : ${wishDataList.length}");
          update();
        } else {
          wishDataList.clear();
          Fluttertoast.showToast(
            msg: 'WishList Get Failed. Please try again later...!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          update();
        }
      });
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> removeFromWishListFunction({placeId}) async {
    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isLoading(true);
      bool isRemoved = await userService.addToWishListMethod(
            userId: userId,
            placeId: placeId,
            status: 0,
          ) ??
          false;
      if (isRemoved) {
        log("rmeoved");
      }

      update();
    } catch (e) {
      log(e.toString());
    } finally {
      getWishListFunction();
      isLoading(false);
    }
  }

  gotoMapPlaceLocation({placeId}) {
    if (Get.isRegistered<HomeController>() &&
        Get.isRegistered<BottomNavigationBarController>()) {
      var homeController = Get.find<HomeController>();
      var bottomBarController = Get.find<BottomNavigationBarController>();
      homeController.isMapView.value = true;
      PlaceDetails? singlePlace;
      for (var item in homeController.placeDataList) {
        if (item.id == placeId) {
          singlePlace = item;
        }
      }
      if (singlePlace != null) {
        homeController.selectedPlaceLocation = singlePlace;
      }
      homeController.initialCameraPosition = CameraPosition(
        target: LatLng(
          double.parse(homeController.selectedPlaceLocation!.latitude),
          double.parse(homeController.selectedPlaceLocation!.longitude),
        ),
        tilt: 10,
        zoom: 14.5,
      );

      bottomBarController.selectedIndex.value = 0;
      bottomBarController.locateWindowPop.value = true;
    }
  }

  addPlanToSelectedDay({placeId}) async {
    if (Get.isRegistered<MyplanController>()) {
      var myplanController = Get.find<MyplanController>();

      PlanService planService = PlanService();

      isLoading(true);
      try {
        bool planAdded = await planService.addPlanToDayMethod(
              placeId: placeId,
              dayNumber: myplanController.selectedDayData!.dayNumber,
            ) ??
            false;
        if (planAdded) {
          Fluttertoast.showToast(
              msg: 'Place Added Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.back();
          myplanController.planDaysGetListFunction();
        } else {
          Fluttertoast.showToast(
            msg: 'Place Not Added.\nPlease try again later',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        update();
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getWishListFunction();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
