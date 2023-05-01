import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildinfoController extends GetxController {
  //TODO: Implement ChildinfoController

  final count = 0.obs;
  List<bool> oncolor = [];
  List<bool> ontxtcolor = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  List arrSongList = ["Travel","Sports","Treking","Painting","Outdoor activites","Induvial sports","Reading","Painting"];
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
