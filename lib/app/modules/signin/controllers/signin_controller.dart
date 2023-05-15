import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/login.dart';
import 'package:playze/app/data/service/loginservice.dart';
import 'package:playze/app/routes/app_pages.dart';


class SigninController extends GetxController {
  //TODO: Implement SigninController
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  TextEditingController passwordController = TextEditingController();
  loginService Loginervice = loginService();
  final count = 0.obs;
  var emailstatus = false.obs;
  var passwordstatus = false.obs;
  String status = "";
  LoginModel? a;
  List<Child> childrenList = [];
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

  Future<void> signin() async {
    isLoading(true);
    try{
      LoginModel? sigin = await Loginervice.postlogin(
          emailController.text.trim(),
          passwordController.text.trim()
      );
      log("sigin : ${sigin}");
      if (sigin?.status == 200) {
        SharedPrefs().value.write(SharedPrefs.userIdKey, sigin?.data?.id ?? " ");
        SharedPrefs().value.write(SharedPrefs.tokenKey, sigin?.data?.token ??' ');
        SharedPrefs().value.write(SharedPrefs.emailKey, sigin?.data?.email ?? " ");
        SharedPrefs().value.write(SharedPrefs.fnamenKey, sigin?.data?.firstName ?? " ");
        SharedPrefs().value.write(SharedPrefs.lnameKey, sigin?.data?.lastName ?? " ");
        SharedPrefs().value.write(SharedPrefs.mnumbarKey, sigin?.data?.mobileNumber ?? " ");
        a?.data?.children?.forEach((element) {
          childrenList.add(element);
        });
        SharedPrefs().value.write('favoriteArticles', childrenList.cast<Child>());
        SharedPrefs().value.listenKey(SharedPrefs.childrenKey, (value){
          print('new key is $value');
        });
        for (int i = 0; i < childrenList.length; i++) {
          debugPrint(
              'name ${childrenList[i].name} age: ${childrenList[i].age}');
        }
        // SharedPrefs().value.read(SharedPrefs.childrenKey).forEach((element) {
        //   childrenList.add(element);
        //   // lip.add(element.name);
        // });
        SharedPrefs().value.write(SharedPrefs.setBool, true);
        print(SharedPrefs().value.read(SharedPrefs.setBool));
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.offNamedUntil(Routes.BOTTOM_NAVIGATIONBAR,(route) => false,);
      }else{
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
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
