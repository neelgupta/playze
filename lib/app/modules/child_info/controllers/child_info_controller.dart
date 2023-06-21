import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/filters_model.dart';
import 'package:playze/app/data/service/login_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:playze/app/routes/app_pages.dart';

class ChildInfoController extends GetxController {
  List weekPrice = [];
  List<FilterData> interestsList = [];
  var secelet = [].obs;
  var argumentData = Get.arguments;
  int? count;
  LoginService loginService = LoginService();
  final List<bool> selected = List.generate(3, (index) => false);
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  var cnamestatus = false.obs;
  var cagestatus = false.obs;
  var isChildDataValid = false.obs;
  String status = "";
  FiltersModel? filtersModel;
  String nameListString = "";
  String ageListString = "";
  String interests = "";
  List nameList = [];
  List ageList = [];
  RxBool isLoading = false.obs;
  // SignModel? AutoGenerates;
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
    // log(argumentData[1]);
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fname = SharedPrefs().value.read(SharedPrefs.firstNameKey);
      lname = SharedPrefs().value.read(SharedPrefs.lastNameKey);
      email = SharedPrefs().value.read(SharedPrefs.emailKey);
      pnumbar = SharedPrefs().value.read(SharedPrefs.mobileNumbarKey);
      password = SharedPrefs().value.read(SharedPrefs.passwordKey);
      cpassword = SharedPrefs().value.read(SharedPrefs.passwordKey);
      getinterest(Get.context!);
    });
  }

  Future<void> getinterest(context) async {
    isLoading(true);
    try {
      filtersModel = await loginService.getInterestsMethod();

      if (filtersModel != null) {
        for (var element in filtersModel!.data) {
          interestsList.add(element);
          // lip.add(element.name);
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
      log("interestsList len :: ${interestsList.length}");
      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> signUpApiMethod(context) async {
    interests = selectedInterestIdList.map((e) => e).toList().join(",");
    isLoading(true);
    for (var tc in nameControllersList) {
      log("tc : ${tc.text}");
      nameList.add(tc.text.trim());
      // log(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    nameListString = nameList.map((e) => e).toList().join(",");
    log("ageControllersList : ${nameListString.toString()}");
    for (var tc in ageControllersList) {
      log("tc : ${tc.text}");
      ageList.add(tc.text.trim());
      // log(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    ageListString = ageList.map((e) => e).toList().join(",");
    log("ageControllersList : ${ageListString.toString()}");
    isLoading(true);
    try {
      var signUpData = await loginService.signUpMethod(
        fname,
        lname,
        email,
        pnumbar,
        password,
        cpassword,
        nameListString.trim(),
        ageListString.trim(),
        interests.trim(),
      );
      if (signUpData != null) {
        if (signUpData.status == 200) {
          Fluttertoast.showToast(
              msg: signUpData.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          SharedPrefs().value.write(SharedPrefs.userIdKey, signUpData.data.id);
          SharedPrefs()
              .value
              .write(SharedPrefs.mobileNumbarKey, signUpData.data.mobileNumber);
          SharedPrefs()
              .value
              .write(SharedPrefs.emailKey, signUpData.data.email);
          // SharedPrefs().value.write(SharedPrefs.userIdKey, signUpData?.data.);
          Get.offNamed(Routes.VERIFICATION, arguments: [signUpData.data.id]);
        } else {
          Fluttertoast.showToast(
              msg: signUpData.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Something went wrong. Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
