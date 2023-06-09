import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/emoji.dart';
import 'package:playze/app/data/service/api_list.dart';
import 'package:playze/app/data/service/loginservice.dart';
import 'package:playze/app/routes/app_pages.dart';

class AddProfilePictureController extends GetxController {
  //TODO: Implement AddProfilePictureController

  final count = 0.obs;
  List<String>? tokan;
  String? usersId;
  File? imageFile;
  String? storeimgselected;
  File? f;
  var argumentData = Get.arguments;
  loginService Loginervice = loginService();
  GetEmoji? a;
  RxBool isLoading = false.obs;
  var isPicked = false.obs;
  var ispic = false.obs;
  var isImageSelected = false.obs;
  var imagepath = ''.obs;
  var imagepaths = ''.obs;
  String imagefile = "";
  var imagecamerafile = ''.obs;
  File? imagecameraFile;
  File? ApiListImages;
  List<Datum> data = [];
  List<int>? imageData;
  List<int>? imageDatas;
  String? fileType;
  List<Emoji> images = [];

  TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    usersId = SharedPrefs().value.read(SharedPrefs.userIdKey);
    tokan = SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    print("usersId:+>$usersId");
    getPlasedata();
  }

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print("imageFile=$imageFile");
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
      print("pathimg==$imageFile");
      isPicked.value = true;
      ispic.value = false;
    }
  }

  Future<void> Addprofile() async {
    isLoading(true);
    // if (storeimgselected != null) {
    //   print(storeimgselected);
    //   final response = await http.get(Uri.parse(storeimgselected.toString()));
    //   final documentDirectory = await getApplicationDocumentsDirectory();
    //   f = File(join(documentDirectory.path, 'imagetest.png'));
    //   f!.writeAsBytesSync(response.bodyBytes);
    //   print('f ===> $f');
    // } else {}
    print("imageFile ===> $imageFile");
    try {
      Map<String, String> data = {
        "user_id": usersId!,
        "user_name": otpController.text.trim(),
      };
      var postUri = Uri.parse(ApiUrlList.addprofile);
      var request = http.MultipartRequest("POST", postUri);
      request.headers['Authorization'] = "Bearer ${(tokan![1])}";
      request.fields.addAll(data);
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'image', imageFile != null ? imageFile!.path : f!.path);
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
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        SharedPrefs().value.write(SharedPrefs.setBool, true);
        Get.offNamedUntil(
          Routes.BOTTOM_NAVIGATIONBAR,
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(
            msg: '${map['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.back();
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getPlasedata() async {
    isLoading(true);
    try {
      a = await Loginervice.getemoji();
      a?.data?.forEach((element) {
        data.add(element);
        // lip.add(element.name);
      });
      for (var i = 0; i < data.length; i++) {
        data[i].emojis?.forEach((element) {
          images.add(element);
          // lip.add(element.name);
        });
      }
      update();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
