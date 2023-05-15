import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/aboutclass.dart';
import 'package:playze/app/data/service/Userservise.dart';

class AboutusController extends GetxController {
  //TODO: Implement AboutusController

  final count = 0.obs;
  AboutModel? a;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAbout(Get.context!);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAbout(context) async {
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
