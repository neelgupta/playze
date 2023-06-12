import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/app/data/modal/class.dart';
import 'package:playze/app/data/service/Userservise.dart';
import 'package:provider/provider.dart';

import '../../../data/modal/get_category_filter_model.dart';
import '../../../data/modal/get_search_filter_model.dart';
import '../../../data/provider/filter_provider.dart';
import '../../BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';
import '../../home/controllers/home_controller.dart';

class SearchScreenController extends GetxController {
  //TODO: Implement SearchController

  hp? a;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  List<dp> CategoryList = [];

  List<CategoryFilterData> filteredCatList = [];
  var filterProv = Provider.of<FilterProvider>(Get.context!);

  GetCategoryFilterModel? getCategoryFilterModel;
  GetSearchFilterModel? getSearchFilterModel;

  List<PlaceNameData> placeNameList = [];

  TextEditingController searchController = TextEditingController();

  late Position currentLocation;
  LocationPermission? permission;

  RxString selectedId = "".obs;

  RxString currentLattitude = "".obs;
  RxString currentLongitude = "".obs;
  @override
  void onInit() {
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    getCategorylist();
    // });
  }

  Future<void> getCategorylist() async {
    isLoading(true);
    try {
      a = await usersevise.getCategorylist();
      for (var element in a!.data) {
        CategoryList.add(element);
        // lip.add(element.name);
      }
      for (int i = 0; i < CategoryList.length; i++) {
        log("CategoryList[i].id : ${CategoryList[i].id}");
        for (var item in filterProv.filteredCatdataList) {
          log("item.id : ${item.id}");
          if (CategoryList[i].id == item.id) {
            CategoryList[i].isSelected = true;
          }
        }
      }
      update();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void clearAllFilterAndSearch() {
    var homeCont = Get.find<HomeController>();

    searchController.clear();
    filterProv.updateSearchData(searchController.text);

    homeCont.isFiltered.value = false;
    homeCont.placeFilteredList.clear();

    for (var item in CategoryList) {
      item.isSelected = false;
    }
    filterProv.updateFilterDataList([]);

    update();
    Get.back();
  }

  Future<void> filterPlacesListBySearchData() async {
    try {
      isLoading(true);

      for (var item in CategoryList) {
        item.isSelected = false;
      }
      filterProv.updateFilterDataList([]);

      permission = await Geolocator.requestPermission();
      currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLattitude.value = currentLocation.latitude.toString();

      currentLongitude.value = currentLocation.longitude.toString();

      // var catStringids =
      //     selectedCatIdList.toString().split("[")[1].split("]")[0];

      filterProv.updateSearchData(searchController.text.trim());

      getSearchFilterModel = await usersevise.searchDataGetList(
        searchData: searchController.text.trim(),
      );
      // filteredCatList.forEach((element) {
      //   filterList.add(element);
      //   // lip.add(element.name);
      // });
      // a?.data.forEach((element) {
      //   isbool.add(false);
      //   update();
      // });
      if (getSearchFilterModel != null) {
        log("getSearchFilterModel ::${getSearchFilterModel != null}");
        placeNameList = getSearchFilterModel!.data.placeDetails;
        log("getSearchFilterModel!.data.placeName.length ::${getSearchFilterModel!.data.placeDetails.length}");
        if (placeNameList.isEmpty) {
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
        filterHomeScreenPlacesBySearchData();
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

  filterHomeScreenPlacesBySearchData() {
    if (Get.isRegistered<HomeController>()) {
      var homeCont = Get.find<HomeController>();

      homeCont.isFiltered.value = true;
      homeCont.placeFilteredList.clear();

      for (var place in placeNameList) {
        for (var item in homeCont.placeDataList) {
          if (place.id == item.id) {
            homeCont.placeFilteredList.add(item);
          }
        }
      }

      if (homeCont.placeFilteredList.isNotEmpty) {
        log("in if not null  ${homeCont.placeFilteredList.length}");
        homeCont.selectedPlaceLocation = homeCont.placeFilteredList.first;
        homeCont.markers.clear();
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

          update();
          // isLoading(false);
        }
      } else {
        homeCont.markers.clear();
        // filterProv.updateFilterDataList([]);
      }

      log("homeCont markers len is : ${homeCont.markers.length}");
      log("homeCont.placeFilteredList len ::${homeCont.placeFilteredList.length}");

      homeCont.update();
    }

    Get.back();
  }

  Future<void> filterPlacesListByCategory() async {
    try {
      isLoading(true);
      permission = await Geolocator.requestPermission();
      currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLattitude.value = currentLocation.latitude.toString();

      currentLongitude.value = currentLocation.longitude.toString();

      // var catStringids =
      //     selectedCatIdList.toString().split("[")[1].split("]")[0];

      getCategoryFilterModel = await usersevise.categoryFilterGetList(
        categoryFilterIdList: selectedId.value,
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
}
