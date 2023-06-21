import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/common_message_data.dart';

import '../../../data/service/user_service.dart';

class ContactUsController extends GetxController {
  final count = 0.obs;
  TextEditingController fName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController massage = TextEditingController();
  UserService userService = UserService();
  RxBool isLoading = false.obs;

  GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();

  Future<void> userContactus() async {
    isLoading(true);
    try {
      CommonMessageData? contactUs = await userService.contactUsMethod(
        fName.text.trim(),
        email.text.trim(),
        massage.text.trim(),
      );
      if (contactUs != null) {
        if (contactUs.status == 200) {
          fName.text = "";
          email.text = "";
          massage.text = "";
          Fluttertoast.showToast(
              msg: contactUs.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.back();
        } else {
          Fluttertoast.showToast(
              msg: contactUs.message,
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
