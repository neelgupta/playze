import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/comman.dart';

import '../../../data/service/Userservise.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

  var getdata = Get.arguments;
  TextEditingController CurrentPassword = TextEditingController();
  TextEditingController NewPassword = TextEditingController();
  TextEditingController RetypeNewPassword = TextEditingController();
  RxBool isLoading = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Usersevise usersevise = Usersevise();
  String? id;
  @override
  void onInit() {
    super.onInit();
    id = SharedPrefs().value.read(SharedPrefs.userIdKey);
    print(id);
  }

  Future<void> userChengpassword() async {
    isLoading(true);
    try {
      Commonmsg? sigin = await usersevise.postUserChengpassword(
          id,
          CurrentPassword.text.trim(),
          NewPassword.text.trim(),
          RetypeNewPassword.text.trim());
      if (sigin?.status == 200) {
        CurrentPassword.text = "";
        NewPassword.text = "";
        RetypeNewPassword.text = "";
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.back();
      } else {
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
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
