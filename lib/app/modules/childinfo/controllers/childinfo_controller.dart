import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/class.dart';
import 'package:playze/app/data/modal/signup.dart';
import 'package:playze/app/data/service/loginservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildinfoController extends GetxController {
  //TODO: Implement ChildinfoController

  List weekPrice = [];
  List<dp> interestsList = [];
  var secelet = [].obs;
  var argumentData = Get.arguments;
  int? count;
  loginService Loginervice = loginService();
  final List<bool> selected = List.generate(3, (index) => false);
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  var cnamestatus = false.obs;
  var cagestatus = false.obs;
  String status = "";
  hp? a;
  String nameListString = "";
  String ageListString = "";
  String Interest = "";
  List nameList = [];
  List ageList = [];
  RxBool isLoading = false.obs;
  SignModel? AutoGenerates;
  List<String> lip = [];
  List<bool> counts = [];
  List<String> selectedInterestIdList = [];
  List<TextEditingController> nameControllersList = [TextEditingController()];
  List<TextEditingController> ageControllersList = [TextEditingController()];
  String? fname;
  String? lname;
  String? email;
  String? pnumbar;
  String? password;
  String? cpassword;
  @override
  void onInit() {
    fname =  SharedPrefs().value.read(SharedPrefs.fnamenKey);
    lname =  SharedPrefs().value.read(SharedPrefs.lnameKey);
    email =  SharedPrefs().value.read(SharedPrefs.emailKey);
    pnumbar =  SharedPrefs().value.read(SharedPrefs.mnumbarKey);
    password =  SharedPrefs().value.read(SharedPrefs.passwordKey);
    cpassword =  SharedPrefs().value.read(SharedPrefs.passwordKey);
    // print(argumentData[1]);
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getinterest(Get.context!);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getinterest(context) async {
    isLoading(true);
    try {
      a = await Loginervice.getinterest();
      a?.data.forEach((element) {
        interestsList.add(element);
        // lip.add(element.name);
      });
      print(lip);
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }

    // Get.back();
  }

  Future<void> signUp(context) async {
    Interest = selectedInterestIdList.map((e) => e).toList().join(",");
    isLoading(true);
    for(var tc in nameControllersList){
      log("tc : ${tc.text}");
      nameList.add(tc.text.trim());
      // print(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    nameListString = nameList.map((e) => e).toList().join(",");
    log("ageControllersList : ${nameListString.toString()}");
    for(var tc in ageControllersList){
      log("tc : ${tc.text}");
      ageList.add(tc.text.trim());
      // print(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    ageListString = ageList.map((e) => e).toList().join(",");
    log("ageControllersList : ${ageListString.toString()}");
    isLoading(true);
    try {
      var sigin = await Loginervice.postsignup(
          fname,
          lname,
          email,
          pnumbar,
          password,
          cpassword,
          nameListString.trim(),
          ageListString.trim(),
          Interest.trim());
      if (sigin?.status == 200) {
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        SharedPrefs().value.write(SharedPrefs.userIdKey, sigin?.data.id);
        SharedPrefs().value.write(SharedPrefs.mnumbarKey, sigin?.data.mobileNumber);
        SharedPrefs().value.write(SharedPrefs.emailKey, sigin?.data.email);
        // SharedPrefs().value.write(SharedPrefs.userIdKey, sigin?.data.);
        Get.offNamed(Routes.VERIFICATION, arguments: [sigin?.data.id]);
      } else {
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }

}}
