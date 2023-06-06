import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/workmodal.dart';
import 'package:playze/app/data/service/Userservise.dart';

class WorkController extends GetxController {
  //TODO: Implement WorkController

  RxBool isLoading = false.obs;
  Usersevise usersevise = Usersevise();
  WorkModal? a;
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

  Future<void> getwork() async {
    isLoading(true);
    try {
      a = await usersevise.getwork();
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
