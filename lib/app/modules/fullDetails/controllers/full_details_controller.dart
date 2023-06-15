import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/app/data/modal/placeclass.dart';

import '../../../../Reusability/utils/shared_prefs.dart';
import '../../../data/modal/get_nearby_model.dart';
import '../../../data/modal/get_reviews_model.dart';
import '../../../data/service/Userservise.dart';

class FullDetailsController extends GetxController {
  //TODO: Implement FullDetailsController

  final count = 0.obs;
  var tabon = false.obs;
  var placeDataId = Get.arguments[0];
  var isImagesAddSelected = "".obs;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  RxBool viewMoreReviews = false.obs;
  int reviewsCount = 1;
  WorkSpaceDetailModel? wSData;

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
    userdeletechildren(placeDataId);
    // getNearByPlaces();
  }

  Future<void> userdeletechildren(id) async {
    isLoading(true);
    try {
      wSData = await usersevise.postdataplace({"id": id});
      // var long2 =  num.tryParse(a?.data?.totalRating)?.toDouble();

      if (wSData != null) {
        placeLocation = LatLng(
          double.parse(wSData!.data.latitude),
          double.parse(wSData!.data.longitude),
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

      getNearByModel = await usersevise.getNearbyPlaces(
        placeId: placeDataId,
      );

      if (getNearByModel != null) {
        nearByPlacesList.addAll(getNearByModel!.data);
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
      getReviewsModel = await usersevise.getPlaceReviews(placeId: placeDataId);
      // var long2 =  num.tryParse(a?.data?.totalRating)?.toDouble();

      if (getReviewsModel != null) {
        reviewAllData = getReviewsModel!.data;

        // for (var vidFile in reviewAllData!.reviewVideo) {
        //   final thumbnailPath = await VideoThumbnail.thumbnailFile(
        //     video: vidFile.video,
        //     thumbnailPath: (await getTemporaryDirectory()).path,
        //     imageFormat: ImageFormat.PNG,

        //     // maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        //     quality: 75,
        //   );

        //   log("Image thumbnailPath : $thumbnailPath");

        //   vidFile.videoThumbnail = thumbnailPath!;
        // }
        // placeLocation = LatLng(
        //   double.parse(wSData!.data.latitude),
        //   double.parse(wSData!.data.longitude),
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
      bool? addedToWS = await usersevise.addWorkSpaceToMyWorkSpace(
        userId: userId,
        placesId: placeId,
        status: status,
      );
      // var long2 =  num.tryParse(a?.data?.totalRating)?.toDouble();

      if (addedToWS!) {
        log("wergyefre done adding to ws");
        Fluttertoast.showToast(
            msg: "Playzee workspace added successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
