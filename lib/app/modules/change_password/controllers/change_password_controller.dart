import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/service/login_service.dart';
import 'package:playze/app/data/service/user_service.dart';
import 'package:playze/reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/common_message_data.dart';

class ChangePasswordController extends GetxController {
  var getdata = Get.arguments;
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController retypeNewPassword = TextEditingController();
  TextEditingController forgotPassController = TextEditingController();

  var forgotPassFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isForgotLoading = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserService userService = UserService();
  LoginService loginService = LoginService();
  String? id;
  @override
  void onInit() {
    super.onInit();
    id = SharedPrefs().value.read(SharedPrefs.userIdKey);
    log("id $id");
  }

  Future<void> forgotPasswordFunction({placeId}) async {
    try {
      // var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isForgotLoading(true);
      bool isSuccess = await loginService.forgotPasswordMethod(
            emailID: forgotPassController.text.trim(),
          ) ??
          false;
      if (isSuccess) {
        Get.back();
      }

      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isForgotLoading(false);
    }
  }

  Future<void> userChangePassword() async {
    isLoading(true);
    try {
      CommonMessageData? changePass =
          await userService.userChangePasswordMethod(
        id,
        currentPassword.text.trim(),
        newPassword.text.trim(),
        retypeNewPassword.text.trim(),
      );
      if (changePass != null) {
        if (changePass.status == 200) {
          currentPassword.text = "";
          newPassword.text = "";
          retypeNewPassword.text = "";
          Fluttertoast.showToast(
              msg: changePass.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.back();
        } else {
          Fluttertoast.showToast(
              msg: changePass.message,
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
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
