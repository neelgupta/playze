import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/comman.dart';

import '../../../data/service/Userservise.dart';

class ContactUsController extends GetxController {
  //TODO: Implement ContactUsController

  final count = 0.obs;
  TextEditingController FName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Massage = TextEditingController();
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;

  GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> userContactus() async {
    isLoading(true);
    try {
      Commonmsg? sigin = await usersevise.postcontactus(
        FName.text.trim(),
        Email.text.trim(),
        Massage.text.trim(),
      );
      if (sigin?.status == 200) {
        FName.text = "";
        Email.text = "";
        Massage.text = "";
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
