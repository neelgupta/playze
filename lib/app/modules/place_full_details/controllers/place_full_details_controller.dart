import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:playze/app/data/modal/workspace_detail_model.dart';

import '../../../../reusability/utils/shared_prefs.dart';
import '../../../data/modal/get_nearby_model.dart';
import '../../../data/modal/get_reviews_model.dart';
import '../../../data/service/plan_service.dart';
import '../../../data/service/user_service.dart';
import '../../myplan/controllers/myplan_controller.dart';

class PlaceFullDetailsController extends GetxController {
  final count = 0.obs;
  var tabon = false.obs;
  var placeDataId = Get.arguments[0];
  var isImagesAddSelected = "".obs;
  UserService userService = UserService();
  RxBool isLoading = false.obs;
  RxBool viewMoreReviews = false.obs;
  int reviewsCount = 1;
  WorkSpaceDetailModel? placeData;

  GetNearByModel? getNearByModel;

  List<NearByPlaceData> nearByPlacesList = [];
  GetReviewsModel? getReviewsModel;

  RData? reviewAllData;
  late Position currentLocation;
  LocationPermission? permission;

  RxString currentLattitude = "".obs;
  RxString currentLongitude = "".obs;

  LatLng? placeLocation;
  @override
  void onInit() {
    super.onInit();
    getPlaceDetails(placeDataId);
    // getNearByPlaces();
  }

  void openLocInMap({
    required double lat,
    required double lon,
    required String locationName,
  }) async {
    // final url =
    //     Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    // await canLaunchUrl(url);
    // if (await canLaunchUrlString(url)) {
    // } else {
    //   throw 'Could not launch $url';
    // }

    final availableMaps = await MapLauncher.installedMaps;
    log("availableMaps :: ${availableMaps.toString()}"); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(lat, lon),
      title: locationName,
    );
  }

  Future<void> getPlaceDetails(id) async {
    isLoading(true);
    try {
      placeData = await userService.getPlaceDetailsMethod({"id": id});

      if (placeData != null) {
        placeLocation = LatLng(
          double.parse(placeData!.data.latitude),
          double.parse(placeData!.data.longitude),
        );
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
    } catch (e) {
      rethrow;
    } finally {
      // isLoading(false);
      getNearByPlaces();
    }
  }

  Future<void> getNearByPlaces() async {
    isLoading(true);
    try {
      permission = await Geolocator.requestPermission();
      currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLattitude.value = currentLocation.latitude.toString();

      currentLongitude.value = currentLocation.longitude.toString();

      getNearByModel = await userService.getNearbyPlacesMethod(
        placeId: placeDataId,
      );

      if (getNearByModel != null) {
        nearByPlacesList.clear();
        nearByPlacesList.addAll(getNearByModel!.data);
      } else {
        // Fluttertoast.showToast(
        //   msg: 'Please try again later...!',
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.blue,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      }
      log("nearByPlacesList len is : ${nearByPlacesList.length}");
    } catch (e) {
      rethrow;
    } finally {
      // isLoading(false);
      getPlaceReviewsList();
    }
  }

  Future<void> getPlaceReviewsList() async {
    isLoading(true);
    try {
      getReviewsModel =
          await userService.getPlaceReviewsMethod(placeId: placeDataId);
      // var long2 =  num.tryParse(a?.data?.totalRating)?.toDouble();

      if (getReviewsModel != null) {
        reviewAllData = getReviewsModel!.data;
      } else {
        // Fluttertoast.showToast(
        //   msg: 'Please try again later...!',
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.blue,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> addWorkSpaceToMyWorkSpace(
      {required String placeId, required String status}) async {
    isLoading(true);
    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);
      // bool addedToWorkSpace =
      await userService.addWorkSpaceToMyWorkSpaceMethod(
            userId: userId,
            placesId: placeId,
            status: status,
          ) ??
          false;
      // var long2 =  num.tryParse(a?.data?.totalRating)?.toDouble();

      // if (addedToWorkSpace) {
      //   log("wergyefre done adding to ws");
      //   Fluttertoast.showToast(
      //       msg: "Playzee workspace added successfully.",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.blue,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // } else {
      //   Fluttertoast.showToast(
      //     msg: 'Workspace adding failed. Please try again later...!',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.blue,
      //     textColor: Colors.white,
      //     fontSize: 16.0,
      //   );
      // }
    } catch (e) {
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

  Future<void> addTowishListFunction({placeId}) async {
    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isLoading(true);
      await userService
          .addToWishListMethod(
        userId: userId,
        placeId: placeId,
        status: 1,
      )
          .then((value) {
        if (value!) {
          getPlaceDetails(placeDataId);
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

  Future<void> removeFromWishListFunction({placeId}) async {
    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isLoading(true);
      await userService
          .addToWishListMethod(
        userId: userId,
        placeId: placeId,
        status: 0,
      )
          .then((value) {
        if (value! == true) {
          getPlaceDetails(placeDataId);
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
