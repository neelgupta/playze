import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/plaseModel.dart';
import 'package:playze/app/data/service/Userservise.dart';
import 'package:playze/app/data/service/plan_service.dart';
import 'package:playze/app/modules/myplan/controllers/myplan_controller.dart';

class AddplacesController extends GetxController {
  final count = 0.obs;
  Usersevise usersevise = Usersevise();
  PlaceDataModel? placeModel;
  RxBool isLoading = false.obs;
  List<PlaceDetails> Data = [];
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
      placeModel = await usersevise.getPlasedata(
        latitudeValue: currentLocation.latitude,
        longitudeValue: currentLocation.longitude,
      );
      placeModel?.data?.forEach((element) {
        Data.add(element);
        // lip.add(element.name);
      });
      for (int i = 0; i < Data.length; i++) {
        placeModel?.data?[i].images?.forEach((element) {
          images.add(element);
          // lip.add(element.name);
        });
      }
      update();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  addPlanToSelectedDay({placeId}) async {
    if (Get.isRegistered<MyplanController>()) {
      var myplanController = Get.find<MyplanController>();

      isLoading(true);
      try {
        bool planAdded = await planService.addPlanToDay(
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
          // Fluttertoast.showToast(
          //     msg: 'Place Not Added Something Went wrong',
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.blue,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
        }
        update();
      } catch (e) {
        print(e.toString());
      } finally {
        isLoading(false);
      }
    }
  }
}
