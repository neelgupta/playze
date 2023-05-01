

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController

  final count = 0.obs;
  File? imageFile;
  var isPicked = false.obs;
  List weekPrice = [];
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController YourLocation = TextEditingController();
  TextEditingController ChildrenName = TextEditingController();
  TextEditingController ChildrenAge = TextEditingController();
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

  void selectFile() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile = File(file.path);
      isPicked.value = true;
      print(imageFile);
      update();
    }
  }

  void increment() => count.value++;
}
