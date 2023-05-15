import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/class.dart';
import 'package:playze/app/data/service/Userservise.dart';

class FilterController extends GetxController {
  //TODO: Implement FilterController

  hp? a;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  List<dp> filterList = [];
  List<bool> isbool = [];

  @override
  void onInit() {
    super.onInit();
    getfilterList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getfilterList() async {
    try {
    isLoading(true);
      a = await usersevise.getCategorylist();
      a?.data.forEach((element) {
        filterList.add(element);
        // lip.add(element.name);
      });
    a?.data.forEach((element) {
      isbool.add(false);
      update();
    });

      for(int i = 0 ; i < filterList.length ; i++) {
        print(filterList[i].name);
      }
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
