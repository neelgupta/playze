import 'package:get/get.dart';
import 'package:playze/app/data/modal/placeclass.dart';

import '../../../data/service/Userservise.dart';

class FullDetailsController extends GetxController {
  //TODO: Implement FullDetailsController

  final count = 0.obs;
  var tabon = false.obs;
  var argumentData = Get.arguments[0];
  var isImagesAddSelected="".obs;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  WorkSpaceDetailModel? wSData;
  @override
  void onInit() {
    super.onInit();
    userdeletechildren(argumentData);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> userdeletechildren(id) async {
    isLoading(true);
    try {
      wSData = await usersevise.postdataplace({"id": id});
      // var long2 =  num.tryParse(a?.data?.totalRating)?.toDouble();
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
