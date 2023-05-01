import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  //TODO: Implement VerificationController

  final count = 0.obs;
  TextEditingController otpController = TextEditingController();
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
