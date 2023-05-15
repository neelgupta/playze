import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/aboutclass.dart';
import 'package:playze/app/data/service/Userservise.dart';

class TermsConditionsController extends GetxController {
  //TODO: Implement TermsConditionsController

  final count = 0.obs;
  AboutModel? a;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();

      getAbout();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAbout() async {
    isLoading(true);
    try {
      a = await usersevise.getAboutus();
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
