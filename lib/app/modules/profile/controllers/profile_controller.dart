import 'package:get/get.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/login.dart';
import 'package:playze/app/data/service/Userservise.dart';

import '../../../data/modal/userdata.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  String? id;
  String? lname;
  String? email;
  String? mnumbar;
  List<Children> childrenList = [];
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
      childrenList.clear();
      a = await usersevise.getdata(id);
      a?.data?.children?.forEach((element) {
        childrenList.add(element);
        for(var i = 0; i<childrenList.length; i ++){
          print(childrenList[i].name);
        }
      });
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
