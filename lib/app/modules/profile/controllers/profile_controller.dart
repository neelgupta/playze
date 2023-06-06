import 'dart:developer';

import 'package:get/get.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/service/Userservise.dart';

import '../../../data/modal/userdata.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  String? id;
  String? lname;
  String? email;
  String? mnumbar;
  List<ChildrenDetails> childrenList = [];
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  DataModal? a;

  @override
  void onInit() {
    super.onInit();
    id = SharedPrefs().value.read(SharedPrefs.userIdKey);
    getAbout();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAbout() async {
    isLoading(true);
    try {
      a = await usersevise.getdata(id);

      if (a != null) {
        childrenList.clear();
        childrenList.addAll(a!.data.children);
        // for (var element in a!.data.children) {
        // }

        // for (var i = 0; i < childrenList.length; i++) {
        //   log("childrenList[i].name :: ${childrenList[i].name}");
        // }
        update();
      }

      log("childrenList.length :: ${childrenList.length}");
    } catch (e) {
      log("${e.toString()}");
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
