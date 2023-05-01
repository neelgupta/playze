import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

  final count = 0.obs;
  TextEditingController CurrentPassword = TextEditingController();
  TextEditingController NewPassword = TextEditingController();
  TextEditingController RetypeNewPassword  = TextEditingController();
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

  void increment() => count.value++;
}
