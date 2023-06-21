import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:playze/reusability/utils/shared_prefs.dart';

import 'package:playze/app/data/service/login_service.dart';

import '../../../data/modal/get_emoji_model.dart';
import '../../../data/service/api_url_list.dart';
import '../../../routes/app_pages.dart';

class AddProfilePictureController extends GetxController {
  final count = 0.obs;
  List<String>? tokan;
  String? usersId;
  File? imageFile;
  final isEmojiSelected = false.obs;
  // String? storeimgselected;

  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  File? f;
  var argumentData = Get.arguments;
  LoginService loginService = LoginService();

  RxBool isLoading = false.obs;
  var isPicked = false.obs;
  var ispic = false.obs;
  var isImageSelected = false.obs;
  var imagepath = ''.obs;
  var imagepaths = ''.obs;
  String imagefile = "";
  var imagecamerafile = ''.obs;
  File? imagecameraFile;
  File? apiListImages;

  GetEmojiModel? getEmojiModel;
  List<ActiveEmojiData> activeEmojiDataList = [];
  List<int>? imageData;
  List<int>? imageDatas;
  String? fileType;
  List<EmojiData> imagesList = [];
  EmojiData? selectedEmoji;

  TextEditingController profileNameController = TextEditingController();

  var isError = false.obs;
  RxString errorString = "".obs;

  @override
  void onInit() {
    super.onInit();
    usersId = SharedPrefs().value.read(SharedPrefs.userIdKey);
    tokan = SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    log("usersId : : $usersId");
    getActiveEmojisList();
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
      log("imageFile=$imageFile");
      isPicked.value = true;
      ispic.value = false;
      isEmojiSelected.value = false;
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
      log("pathimg==$imageFile");
      isPicked.value = true;
      ispic.value = false;
      isEmojiSelected.value = false;
    }
  }

  Future<void> addProfileData() async {
    isLoading(true);

    log("addProfileData image file ===> $imageFile");
    try {
      List<String>? tokan =
          SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
      String newtokan = tokan![1];

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $newtokan"
      };
      Map<String, String> data = {
        "user_id": usersId!.toString(),
        "user_name": profileNameController.text.trim().toString(),
        "type": isEmojiSelected.value ? "1" : "0",
        if (isEmojiSelected.value) "emojis_id": selectedEmoji!.id.toString(),
      };
      var postUri = Uri.parse(ApiUrlList.addprofile);
      var request = http.MultipartRequest("POST", postUri);
      request.headers['Authorization'] = "Bearer ${(tokan[1])}";
      request.fields.addAll(data);
      request.headers.addAll(headers);

      if (!isEmojiSelected.value) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'image',
          imageFile!.path,
        );
        request.files.add(multipartFile);
        log(' request.files : ${request.files.first.filename}');
      }

      log("addProfileData postUri ===> $postUri");
      log("addProfileData request.headers ===> ${request.headers}");
      log("addProfileData req data ===> $data");

      http.StreamedResponse response = await request.send();
      log('code: ${response.statusCode}');
      final res = await http.Response.fromStream(response);
      log('body: ${res.body}');

      if (res.statusCode == 200) {
        Map map = jsonDecode(res.body);
        if (map['status'] == 200) {
          Fluttertoast.showToast(
            msg: '${map['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
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
            fontSize: 16.0,
          );
          // Get.back();
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getActiveEmojisList() async {
    try {
      isLoading(true);
      getEmojiModel = await loginService.getActiveEmojisListMethod();

      if (getEmojiModel != null) {
        activeEmojiDataList = getEmojiModel!.data;
      } else {
        Fluttertoast.showToast(
          msg: 'Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      update();
    } catch (e) {
      log(e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
