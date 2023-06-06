import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/aboutclass.dart';
import 'package:playze/app/data/service/Userservise.dart';

class AboutusController extends GetxController {
  //TODO: Implement AboutusController

  final count = 0.obs;
  AboutModel? a;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAbout(Get.context!);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAbout(context) async {
    isLoading(true);
    try {
      a = await usersevise.getAboutus();
      if (a?.status == 200) {
        Fluttertoast.showToast(
            msg: '${a?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        Fluttertoast.showToast(
            msg: '${a?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
