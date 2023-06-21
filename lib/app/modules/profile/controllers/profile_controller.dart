import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/reusability/utils/shared_prefs.dart';

import '../../../data/modal/user_data_model.dart';
import '../../../data/service/user_service.dart';

class ProfileController extends GetxController {
  final count = 0.obs;
  String? id;
  String? lname;
  String? email;
  String? mnumbar;
  List<ChildrenDetails> childrenList = [];
  UserService userService = UserService();
  RxBool isLoading = false.obs;
  UserDataModal? userDataModal;

  @override
  void onInit() {
    super.onInit();
    getUserProfileData();
  }

  Future<void> getUserProfileData() async {
    isLoading(true);
    try {
      id = SharedPrefs().value.read(SharedPrefs.userIdKey);
      userDataModal = await userService.getUserDetailsMethod(id);

      if (userDataModal != null) {
        childrenList.clear();
        childrenList.addAll(userDataModal!.data.children);
        // for (var element in a!.data.children) {
        // }

        // for (var i = 0; i < childrenList.length; i++) {
        //   log("childrenList[i].name :: ${childrenList[i].name}");
        // }
        update();
      } else {
        Fluttertoast.showToast(
          msg:
              'Something went wrong getting user details. Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      log("childrenList.length :: ${childrenList.length}");
    } catch (e) {
      log(e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
