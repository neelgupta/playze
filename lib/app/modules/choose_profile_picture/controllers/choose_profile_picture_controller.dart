import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChooseProfilePictureController extends GetxController {
  final count = 0.obs;
  File? imageFile;
  File? imagecameraFile;
  var isPicked = false.obs;
  List images = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
  ];

  void selectFile() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile = File(file.path);
      isPicked.value = true;
      log("imageFile $imageFile");
      update();
    }
  }

  void selectcameraFile() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      imagecameraFile = File(file.path);
      isPicked.value = true;
      log("imagecameraFile : $imagecameraFile");
      update();
    }
  }

  void increment() => count.value++;
}
