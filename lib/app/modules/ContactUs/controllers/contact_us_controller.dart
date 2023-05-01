import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  //TODO: Implement ContactUsController

  final count = 0.obs;
  TextEditingController FName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Massage  = TextEditingController();
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
