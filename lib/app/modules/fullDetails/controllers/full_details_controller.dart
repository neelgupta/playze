import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/app/data/modal/placeclass.dart';

import '../../../../Reusability/utils/shared_prefs.dart';
import '../../../data/service/Userservise.dart';

class FullDetailsController extends GetxController {
  //TODO: Implement FullDetailsController

  final count = 0.obs;
  var tabon = false.obs;
  var argumentData = Get.arguments[0];
  var isImagesAddSelected = "".obs;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  WorkSpaceDetailModel? wSData;

  LatLng? placeLocation;
  @override
  void onInit() {
    super.onInit();
    userdeletechildren(argumentData);
  }

  Future<void> userdeletechildren(id) async {
    isLoading(true);
    try {
      wSData = await usersevise.postdataplace({"id": id});
      // var long2 =  num.tryParse(a?.data?.totalRating)?.toDouble();

      if (wSData != null) {
        placeLocation = LatLng(
          wSData!.data.latitude.toDouble(),
          wSData!.data.longitude.toDouble(),
        );
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
            msg: 'Workspace Added Successfully.',
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
