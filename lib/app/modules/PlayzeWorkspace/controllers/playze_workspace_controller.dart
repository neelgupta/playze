import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/workmodal.dart';
import 'package:playze/app/data/service/Userservise.dart';

class PlayzeWorkspaceController extends GetxController {
  //TODO: Implement PlayzeWorkspaceController

  final count = 0.obs;
  RxBool isLoading = false.obs;
  Usersevise usersevise = Usersevise();
  WorkModal? workData;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getwork();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getwork() async {
    isLoading(true);
    try {
      workData = await usersevise.getwork();
      if (workData?.status == 200) {
        // Fluttertoast.showToast(
        //     msg: '${workData?.message}',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.blue,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: '${workData?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      update();
    } catch (e) {
      log("exepection is :${e.toString()}");

      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
