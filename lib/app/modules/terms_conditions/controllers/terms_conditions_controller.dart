import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/service/user_service.dart';

import '../../../data/modal/about_model.dart';

class TermsConditionsController extends GetxController {
  final count = 0.obs;
  AboutModel? aboutUsData;
  UserService userService = UserService();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAbout();
  }

  Future<void> getAbout() async {
    isLoading(true);
    try {
      aboutUsData = await userService.getAboutUsMethod();
      if (aboutUsData != null) {
        if (aboutUsData?.status == 200) {
          Fluttertoast.showToast(
              msg: '${aboutUsData?.message}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: '${aboutUsData?.message}',
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
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
