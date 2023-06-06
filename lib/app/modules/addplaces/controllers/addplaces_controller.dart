import 'package:get/get.dart';
import 'package:playze/app/data/modal/plaseModel.dart';
import 'package:playze/app/data/service/Userservise.dart';

class AddplacesController extends GetxController {
  //TODO: Implement AddplacesController

  final count = 0.obs;
  Usersevise usersevise = Usersevise();
  PlaceData? a;
  RxBool isLoading = false.obs;
  List<Datum> Data = [];
  List<Image> images = [];
  @override
  void onInit() {
    super.onInit();
    getPlasedata();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getPlasedata() async {
    isLoading(true);
    try {
      a = await usersevise.getPlasedata();
      a?.data?.forEach((element) {
        Data.add(element);
        // lip.add(element.name);
      });
      for(int i = 0; i< Data.length ;i++){
        a?.data?[i].images?.forEach((element) {
          images.add(element);
          // lip.add(element.name);
        });
      }
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
