import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/place_data_model.dart';
import 'package:playze/app/data/service/plan_service.dart';
import 'package:playze/app/data/service/user_service.dart';
import 'package:playze/app/modules/myplan/controllers/myplan_controller.dart';

class AddPlacesController extends GetxController {
  final count = 0.obs;
  UserService userService = UserService();
  PlaceDataModel? placeModel;
  RxBool isLoading = false.obs;
  List<PlaceDetails> placeDatalist = [];
  List<ImageData> images = [];

  late Position currentLocation;
  LocationPermission? permission;

  PlanService planService = PlanService();
  @override
  void onInit() {
    super.onInit();
    getPlasedata();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getPlasedata() async {
    isLoading(true);
    try {
      permission = await Geolocator.requestPermission();
      currentLocation = await locateUser();
      placeModel = await userService.getAllPlacesListMethod(
        latitudeValue: currentLocation.latitude,
        longitudeValue: currentLocation.longitude,
      );
      for (var element in placeModel!.data) {
        placeDatalist.add(element);
        // lip.add(element.name);
      }
      for (int i = 0; i < placeDatalist.length; i++) {
        for (var element in placeModel!.data[i].images) {
          images.add(element);
          // lip.add(element.name);
        }
      }
      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  addPlanToSelectedDay({placeId}) async {
    if (Get.isRegistered<MyplanController>()) {
      var myplanController = Get.find<MyplanController>();

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
}
