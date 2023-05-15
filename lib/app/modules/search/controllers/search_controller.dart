import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/class.dart';
import 'package:playze/app/data/service/Userservise.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController

  hp? a;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  List<dp> CategoryList = [];
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategorylist(Get.context!);

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

  Future<void> getCategorylist(context) async {
    isLoading(true);
    try {
      a = await usersevise.getCategorylist();
      a?.data.forEach((element) {
        CategoryList.add(element);
        // lip.add(element.name);
      });

      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
