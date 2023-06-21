import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/app/data/service/user_service.dart';

import '../../../../reusability/utils/shared_prefs.dart';
import '../../../data/modal/place_data_model.dart';
import '../../../data/modal/work_space_model.dart';
import '../../../data/service/plan_service.dart';
import '../../bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../myplan/controllers/myplan_controller.dart';

class PlayzeWorkSpaceController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  UserService userService = UserService();
  WorkSpaceListModel? workSpaceListModel;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    getWorkSpaceList();
  }

  Future<void> getWorkSpaceList() async {
    isLoading(true);
    try {
      workSpaceListModel = await userService.getWorkSpacesListMethod();

      if (workSpaceListModel != null) {
        if (workSpaceListModel?.status == 200) {
        } else {
          Fluttertoast.showToast(
              msg: '${workSpaceListModel?.message}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Please try again later...!',
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
      log("exepection is :${e.toString()}");

      rethrow;
    } finally {
      isLoading(false);
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
          // Get.back();
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

  Future<void> addTowishListFunction({placeId}) async {
    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isLoading(true);
      await userService.addToWishListMethod(
        userId: userId,
        placeId: placeId,
        status: 1,
      );

      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
