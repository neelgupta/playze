import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WriteareviewController extends GetxController {
  //TODO: Implement WriteareviewController

  final count = 0.obs;
  TextEditingController Notes = TextEditingController();
  File? imageFile;
  File? imagevideoFile;
  var isPicked = false.obs;
  var isPickeds = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void Close() {
    imageFile?.path.isEmpty == imageFile?.path;
    update();
    print(imageFile);
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
        print(isPicked);
        update();
    }
  }

   void selectvieoFile() async {
     final ImagePicker _picker = ImagePicker();
     XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      imagevideoFile = File(file.path);
        isPicked.value = true;
        print(imageFile);
        print(isPicked);
        update();
    }
  }
}
