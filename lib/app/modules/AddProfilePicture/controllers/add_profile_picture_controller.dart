import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProfilePictureController extends GetxController {
  //TODO: Implement AddProfilePictureController

  final count = 0.obs;
  File? imageFile;
  var isPicked = false.obs;

  TextEditingController otpController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
