import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/app/data/modal/class.dart';
import 'package:playze/app/data/modal/get_category_filter_model.dart';
import 'package:playze/app/data/service/Userservise.dart';
import 'package:playze/app/modules/BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';
import 'package:playze/app/modules/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../data/provider/filter_provider.dart';

class FilterController extends GetxController {
  //TODO: Implement FilterController

  hp? a;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  RxInt selectedCount = 0.obs;
  List<dp> filterList = [];
  List<bool> isbool = [];
  List<CategoryFilterData> filteredCatList = [];
  late Position currentLocation;
  LocationPermission? permission;

  GetCategoryFilterModel? getCategoryFilterModel;

  var filterProv = Provider.of<FilterProvider>(Get.context!);

  List<String> selectedCatIdList = [];

  RxString currentLattitude = "".obs;
  RxString currentLongitude = "".obs;

  @override
  void onInit() {
    super.onInit();
    getfilterList();
  }

  Future<void> getfilterList() async {
    try {
      isLoading(true);
      a = await usersevise.getCategorylist();
      for (var element in a!.data) {
        filterList.add(element);
        // lip.add(element.name);
      }
      // ignore: unused_local_variable
      for (var element in a!.data) {
        // log("$element");
        isbool.add(false);
        update();
      }

      for (int i = 0; i < filterList.length; i++) {
        // log("filterList[i].id : ${filterList[i].id}");
        for (var item in filterProv.filteredCatdataList) {
          // log("item.id : ${item.id}");
          if (filterList[i].id == item.id) {
            filterList[i].isSelected = true;
          }
        }
      }
      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> categoryFilterSearchApi() async {
    try {
      isLoading(true);
      permission = await Geolocator.requestPermission();
      currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLattitude.value = currentLocation.latitude.toString();

      currentLongitude.value = currentLocation.longitude.toString();

      var catStringids = selectedCatIdList
          .toString()
          .split("[")[1]
          .split("]")[0]
          .removeAllWhitespace;

      getCategoryFilterModel = await usersevise.categoryFilterGetList(
        categoryFilterIdList: catStringids,
        latitude: currentLattitude.value,
        longitude: currentLongitude.value,
      );
      // filteredCatList.forEach((element) {
      //   filterList.add(element);
      //   // lip.add(element.name);
      // });
      // a?.data.forEach((element) {
      //   isbool.add(false);
      //   update();
      // });
      if (getCategoryFilterModel != null) {
        filteredCatList = getCategoryFilterModel!.data;
        if (filteredCatList.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Data Not Available',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }

        // <FilterProvider>;
        filterHomeScreenPlacesList();
      }

      for (int i = 0; i < filteredCatList.length; i++) {
        log("filteredCatList[i].name ::${filteredCatList[i].name}");
      }
      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  filterHomeScreenPlacesList() {
    if (Get.isRegistered<HomeController>()) {
      var homeCont = Get.find<HomeController>();

      homeCont.isFiltered.value = true;
      homeCont.placeFilteredList.clear();

      for (var filter in filteredCatList) {
        for (var item in homeCont.placeDataList) {
          if (filter.id == item.id) {
            homeCont.placeFilteredList.add(item);
          }
        }
      }

      if (homeCont.placeFilteredList.isNotEmpty) {
        homeCont.markers.clear();
        homeCont.selectedPlaceLocation = homeCont.placeFilteredList.first;
        for (int i = 0; i < homeCont.placeFilteredList.length; i++) {
          // final Uint8List markerIcon =
          //     await getBytesFromAsset(images[i].toString(), 100);

          var singlePlace = homeCont.placeFilteredList[i];

          // if (Get.isRegistered<HomeController>()) {
          var bottombarController = Get.find<BottomNavigationbarController>();

          // log(" singlePlace.latitude!.toDouble() ${singlePlace.latitude!.toDouble()}");
          // log(" singlePlace.longitude!.toDouble() ${singlePlace.longitude!.toDouble()}");

          homeCont.markers.add(
            Marker(
              onTap: () {
                bottombarController.locateWindowPop.value =
                    !bottombarController.locateWindowPop.value;
                homeCont.selectedPlaceLocation = singlePlace;
              },
              infoWindow: InfoWindow(
                  title: "${singlePlace.placesName}",
                  snippet: "${singlePlace.address}"),
              flat: true,
              rotation: 1.1,
              zIndex: 10,

              visible: true,

              markerId: MarkerId(singlePlace.id.toString()),
              position: LatLng(
                double.parse(singlePlace.latitude!),
                double.parse(singlePlace.longitude!),
              ),
              // icon: BitmapDescriptor.fromBytes(markerIcon),
            ),
          );

          log("homeCont markers  len is : ${homeCont.markers.length}");
          update();
          // isLoading(false);
        }
      } else {
        homeCont.markers.clear();
        // filterProv.updateFilterDataList([]);
      }

      log("homeCont.placeFilteredList len ::${homeCont.placeFilteredList.length}");

      homeCont.update();
    }

    Get.back();
  }

  clearFilterHomeScreenPlacesList() {
    // if (Get.isRegistered<HomeController>()) {
    for (var item in filterList) {
      item.isSelected = false;
    }
    var homeCont = Get.find<HomeController>();
    isLoading(true);
    homeCont.isFiltered.value = false;
    homeCont.placeFilteredList = [];

    filterProv.updateFilterDataList([]);

    // for (var filter in filteredCatList) {
    //   for (var item inplaceDataList) {
    //     if (filter.id == item.id) {
    //      placeFilteredList.add(item);
    //     }
    //   }
    // }

    if (homeCont.placeDataList.isNotEmpty) {
      homeCont.markers.clear();
      homeCont.selectedPlaceLocation = homeCont.placeDataList.first;
      for (int i = 0; i < homeCont.placeDataList.length; i++) {
        // final Uint8List markerIcon =
        //     await getBytesFromAsset(images[i].toString(), 100);

        var singlePlace = homeCont.placeDataList[i];

        // if (Get.isRegistered<HomeController>()) {
        var bottombarController = Get.find<BottomNavigationbarController>();

        // log(" singlePlace.latitude!.toDouble() ${singlePlace.latitude!.toDouble()}");
        // log(" singlePlace.longitude!.toDouble() ${singlePlace.longitude!.toDouble()}");

        homeCont.markers.add(
          Marker(
            onTap: () {
              bottombarController.locateWindowPop.value =
                  !bottombarController.locateWindowPop.value;
              homeCont.selectedPlaceLocation = singlePlace;
            },
            infoWindow: InfoWindow(
                title: "${singlePlace.placesName}",
                snippet: "${singlePlace.address}"),
            flat: true,
            rotation: 1.1,
            zIndex: 10,

            visible: true,

            markerId: MarkerId(singlePlace.id.toString()),
            position: LatLng(
              double.parse(singlePlace.latitude!),
              double.parse(singlePlace.longitude!),
            ),
            // icon: BitmapDescriptor.fromBytes(markerIcon),
          ),
        );

        log(" markers  len is : ${homeCont.markers.length}");
      }
    }

    log("placeDataList len ::${homeCont.placeDataList.length}");
    update();
    isLoading(false);
    Get.back();
  }
}
