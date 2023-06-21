import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/service/user_service.dart';

import '../../../data/modal/about_model.dart';

class AboutUsController extends GetxController {
  final count = 0.obs;
  AboutModel? aboutData;
  UserService usersevise = UserService();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAbout(Get.context!);
    });
  }

  Future<void> getAbout(context) async {
    isLoading(true);
    try {
      aboutData = await usersevise.getAboutUsMethod();

      if (aboutData != null) {
        if (aboutData?.status == 200) {
          log("about us data ${aboutData?.data.abouteas}");
        } else {
          Fluttertoast.showToast(
            msg: '${aboutData?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
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
