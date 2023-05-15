import 'dart:convert';
import 'dart:io';
import 'package:playze/app/data/service/Api_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/data/modal/comman.dart';
import 'package:playze/app/data/service/loginservice.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class AddProfilePictureController extends GetxController {
  //TODO: Implement AddProfilePictureController

  final count = 0.obs;
  List<String> ? tokan;
  String? usersId;
  File? imageFile;
  var argumentData = Get.arguments;
  RxBool isLoading = false.obs;
  var isPicked = false.obs;
  var ispic = false.obs;
  var imagepath = ''.obs;
  var imagepaths = ''.obs;
  String imagefile = "";
  String imagecamerafile = "";
  File? imagecameraFile;
  List<int>? imageData;
  List<int>? imageDatas;
  String? fileType;
  List images = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
  ];

  TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    usersId = SharedPrefs().value.read(SharedPrefs.userIdKey);
    tokan = SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    print("usersId:+>$usersId");
  }

  @override
  void onReady() {
    super.onReady();
  }

  // void selectFile() async {
  //   XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (file != null) {
  //     imageFile = File(file.path);
  //     isPicked.value = true;
  //     ispic.value = false;
  //     imagefile = file.path;
  //     print("imageFile : ${imagefile}");
  //     // final bytes = imageFile!.readAsBytesSync();
  //     // var decodedImage = await decodeImageFromList(bytes);
  //     // int imgWidth = decodedImage.width;
  //     // int imgHeight = decodedImage.height;
  //     // print('image size: ' + imgWidth.toString() + ' ' + imgHeight.toString());
  //     //   var fileName = (imageFile!.path.split('/').last);
  //     //   fileType = fileName.split('.').last;
  //     //   imageData = bytes;
  //     //   imagepath.value = imageFile!.path;
  //     //   print(imageData);
  //     //   print(fileType);
  //   }
  //   update();
  // }
  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      isPicked.value = true;
      ispic.value = false;
    }
  }

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      isPicked.value = true;
      ispic.value = false;
    }
  }

  // void selectcameraFile() async {
  //   XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (file != null) {
  //     imagecameraFile = File(file.path);
  //     isPicked.value = true;
  //     print(imagecameraFile);
  //     ispic.value = false;
  //     imagecamerafile = imageFile.toString();
  //     print(ispic.value);
  //     update();
  //     final bytes = imageFile!.readAsBytesSync();
  //     var decodedImage = await decodeImageFromList(bytes);
  //     int imgWidth = decodedImage.width;
  //     int imgHeight = decodedImage.height;
  //     print('image size: ' + imgWidth.toString() + ' ' + imgHeight.toString());
  //     var fileName = (imageFile!
  //         .path
  //         .split('/')
  //         .last);
  //     fileType = fileName
  //         .split('.')
  //         .last;
  //     imageDatas = bytes;
  //     imagepaths.value = imageFile!.path;
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> Addprofile() async {
    isLoading(true);
    try{
      Map<String, String> data = {
        "user_id": usersId!,
        "user_name": otpController.text.trim()
      };
      var postUri = Uri.parse(ApiURLList.Addprofile);
      var request = http.MultipartRequest("POST", postUri);
      request.headers['Authorization'] = "Bearer ${(tokan![1])}";
      request.fields.addAll(data);
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'image', imageFile!.path);
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      print('code: ${response.statusCode}');
      final res = await http.Response.fromStream(response);
      print('body: ${res.body}');
      Map map = jsonDecode(res.body);
      if (map['status'] == 200) {
        Fluttertoast.showToast(
            msg: '${map['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
        SharedPrefs().value.write(SharedPrefs.setBool, true);
        Get.offNamedUntil(Routes.BOTTOM_NAVIGATIONBAR, (route) => false,);
      } else {
        Fluttertoast.showToast(
            msg: '${map['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.back();
      }
    }
    catch(e){
      rethrow;
    }
    finally{
      isLoading(false);
    }
  }
}
