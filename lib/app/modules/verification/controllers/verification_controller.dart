import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/otp_model.dart';
import 'package:playze/reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/service/login_service.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../../../data/modal/common_message_data.dart';

class VerificationController extends GetxController {
  final count = 0.obs;
  TextEditingController otpController = TextEditingController();
  LoginService loginService = LoginService();
  var argumentData = Get.arguments;
  RxBool isLoading = false.obs;
  String? usersId;
  String? email;
  String? phonenumbar;
  String? formattedPhoneNumber;

  @override
  void onInit() {
    super.onInit();
    usersId = SharedPrefs().value.read(SharedPrefs.userIdKey);
    email = SharedPrefs().value.read(SharedPrefs.emailKey);
    phonenumbar = SharedPrefs().value.read(SharedPrefs.mobileNumbarKey);
    log("usersId:+>$usersId");
    log("usersId:+>$email");
    log("usersId:+>$phonenumbar");
    formattedPhoneNumber =
        phonenumbar?.replaceFirst("(d{3})(d{3})(d+)", "\$1) \$2-\$3");
  }

  Future<void> sendOtpMethod() async {
    if (otpController.text.trim().isEmpty ||
        otpController.text.trim().length < 4) {
      Fluttertoast.showToast(
        msg: 'Please Enter Correct OTP',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      isLoading(true);
      try {
        OtpModel? otpSent = await loginService.sendOtpMethod(
            argumentData[0], otpController.text.trim());
        if (otpSent != null) {
          if (otpSent.status == 200) {
            Fluttertoast.showToast(
                msg: otpSent.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
            SharedPrefs().value.write(SharedPrefs.tokenKey, otpSent.data.token);
            SharedPrefs()
                .value
                .write(SharedPrefs.userIdKey, otpSent.data.usersId);
            SharedPrefs().value.write(SharedPrefs.setBool, true);
            log("====>${(SharedPrefs().value.read(SharedPrefs.tokenKey))}");
            log("====>${(SharedPrefs().value.read(SharedPrefs.userIdKey))}");
            isLoading(false);
            Get.offNamedUntil(
              Routes.ADD_PROFILE_PICTURE,
              (route) => false,
            );
          } else {
            isLoading(false);
            //  Fluttertoast.showToast(
            //      msg: '${sigin?.message}',
            //      toastLength: Toast.LENGTH_SHORT,
            //      gravity: ToastGravity.BOTTOM,
            //      timeInSecForIosWeb: 1,
            //      backgroundColor: Colors.blue,
            //      textColor: Colors.white,
            //      fontSize: 16.0);
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Something went wrong. Please try again later...!',
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

  Future<void> resendOtpMethod() async {
    isLoading(true);
    try {
      CommonMessageData? otpResent = await loginService.resendOtpMethod(email);
      if (otpResent != null) {
        if (otpResent.status == 200) {
          isLoading(false);
          Fluttertoast.showToast(
              msg: otpResent.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          isLoading(false);
          Fluttertoast.showToast(
              msg: otpResent.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.back();
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Something went wrong. Please try again later...!',
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

  getInitialFormattedNumber(String format, String str) {
    if (str == '') return '';
    var mask = format;
    str.split("").forEach((item) => mask = mask.replaceFirst('x', item));
    return mask.replaceAll('x', "");
  }
}
