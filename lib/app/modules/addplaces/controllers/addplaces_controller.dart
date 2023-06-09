import 'package:get/get.dart';
import 'package:playze/app/data/modal/plaseModel.dart';
import 'package:playze/app/data/service/Userservise.dart';

class AddplacesController extends GetxController {
  //TODO: Implement AddplacesController

  final count = 0.obs;
  Usersevise usersevise = Usersevise();
  PlaceDataModel? placeModel;
  RxBool isLoading = false.obs;
  List<PlaceDetails> Data = [];
  List<Image> images = [];
  @override
  void onInit() {
    super.onInit();
    getPlasedata();
  }

  Future<void> getPlasedata() async {
    isLoading(true);
    try {
      placeModel = await usersevise.getPlasedata();
      placeModel?.data?.forEach((element) {
        Data.add(element);
        // lip.add(element.name);
      });
      for (int i = 0; i < Data.length; i++) {
        placeModel?.data?[i].images?.forEach((element) {
          images.add(element);
          // lip.add(element.name);
        });
      }
      update();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
