import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playze/app/data/service/plan_service.dart';
import 'package:playze/app/data/service/user_service.dart';
import 'package:playze/reusability/shared/custom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../reusability/utils/shared_prefs.dart';
import '../../../data/modal/place_data_model.dart';
import '../../../data/provider/filter_provider.dart';
import '../../bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';
import '../../myplan/controllers/myplan_controller.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var index = 0;
  String action = "Home";
  var isMapView = true.obs;

  RxBool isLoading = false.obs;
  RxBool isFiltered = false.obs;
  RxBool locWhenInUseGranted = false.obs;
  RxBool locAlwaysGranted = false.obs;
  LatLng? positionStream;
  static const LatLng location1 = LatLng(21.230557, 72.821677);
  static const LatLng location2 = LatLng(21.224772, 72.821394);

  GoogleMapController? gMapController;

  UserService userService = UserService();

  PlaceDetails? selectedPlaceLocation;

  TextEditingController searchController = TextEditingController();

  FilterProvider filterProv = Provider.of<FilterProvider>(Get.context!);

  List<String> images = [
    'assets/images/NoPath.png',
    'assets/images/NoPath.png',
    'assets/images/NoPath.png',
    'assets/images/NoPath.png',
    'assets/images/NoPath.png',
    'assets/images/NoPath.png',
  ];
  Uint8List? markerImage;
  List<PlaceDetails> placeDataList = [];

  List<PlaceDetails> placeFilteredList = [];
  PlaceDataModel? placeModel;

  CameraPosition? initialCameraPosition;
  final List<Marker> markers = <Marker>[];
  final List<LatLng> latLang = <LatLng>[
    const LatLng(21.194198910486286, 72.78706006722157),
    const LatLng(21.19339957816572, 72.78677048041395),
    const LatLng(21.19302105335981, 72.78770875175347),
    const LatLng(21.192499528705643, 72.78736592184096),
    const LatLng(21.191952767011255, 72.78837636789889),
    const LatLng(21.191935943542433, 72.7884124552581)
  ];
  BitmapDescriptor icons = BitmapDescriptor.defaultMarker;
  LatLng? center;

  //  = const LatLng(23.812433, 79.305474);
  late Position currentLocation;
  LocationPermission? permission;

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  // void setcoustommarkerIcon(){
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/images/NoPath.png",mipmaps: true).then((icon){
  //     icons = icon;
  //   });
  // }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future requestLocationPermission() async {
    await Permission.location.request();
  }

  Future<void> goToMyCurrentLocation() async {
    // final GoogleMapController controller = await gMapController.;
    permission = await Geolocator.requestPermission();
    currentLocation = await locateUser();
    center = LatLng(currentLocation.latitude, currentLocation.longitude);
    initialCameraPosition = CameraPosition(
      target: center!,
      tilt: 10,
      zoom: 14.5,
    );
    gMapController!
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition!));
    locAlwaysGranted.value =
        await Permission.locationAlways.request().isGranted;

    locWhenInUseGranted.value =
        await Permission.locationWhenInUse.request().isGranted;
    log('permission.value ::  $permission');
    log('locAlwaysGranted.value ::  ${locAlwaysGranted.value}');
    log('locWhenInUseGranted.value ::  ${locWhenInUseGranted.value}');
    update();
  }

  getUserLocation() async {
    isLoading(true);

    try {
      permission = await Geolocator.requestPermission();
      currentLocation = await locateUser();
      center = LatLng(currentLocation.latitude, currentLocation.longitude);
      markers.add(
        Marker(
          onTap: () {
            // controller.locateWindowPop.value = !controller.locateWindowPop.value;
            controller.locateWindowPop.value = false;
          },
          infoWindow: const InfoWindow(title: "My Location"),
          visible: true,

          markerId: const MarkerId('01'),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          // icon: BitmapDescriptor.fromBytes(markerIcon),
        ),
      );

      initialCameraPosition = CameraPosition(
        target: center!,
        tilt: 10,
        zoom: 14.5,
      );
      log('center  :: $center');
      update();
    } catch (e) {
      log("exc :: ${e.toString()}");
    } finally {
      getPlacesList();

      locAlwaysGranted.value =
          await Permission.locationAlways.request().isGranted;

      locWhenInUseGranted.value =
          await Permission.locationWhenInUse.request().isGranted;
      log('permission.value ::  $permission');
      log('locAlwaysGranted.value ::  ${locAlwaysGranted.value}');
      log('locWhenInUseGranted.value ::  ${locWhenInUseGranted.value}');

      // isLoading(false);
    }
  }

  Future<void> getPlacesList() async {
    try {
      isLoading(true);
      await userService
          .getAllPlacesListMethod(
        latitudeValue: currentLocation.latitude,
        longitudeValue: currentLocation.longitude,
      )
          .then((value) {
        placeModel = value;
        if (placeModel != null) {
          placeDataList.clear();
          for (var element in placeModel!.data) {
            placeDataList.add(element);
            // lip.add(element.name);
          }
          log("placeDataList len is : ${placeDataList.length}");
        } else {
          Fluttertoast.showToast(
            msg: 'Please try again later...!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          isLoading(false);
        }
      });

      if (placeDataList.isNotEmpty) {
        selectedPlaceLocation = placeDataList.first;
        for (int i = 0; i < placeDataList.length; i++) {
          var singlePlace = placeDataList[i];
          markers.add(
            Marker(
              onTap: () {
                controller.locateWindowPop.value =
                    !controller.locateWindowPop.value;
                selectedPlaceLocation = singlePlace;
              },
              infoWindow: InfoWindow(
                  title: singlePlace.placesName, snippet: singlePlace.address),
              flat: true,
              // rotation: 1.1,
              zIndex: 10,

              visible: true,

              markerId: MarkerId(singlePlace.id.toString()),
              position: LatLng(
                double.parse(singlePlace.latitude),
                double.parse(singlePlace.longitude),
              ),
              // icon: BitmapDescriptor.fromBytes(markerIcon),
            ),
          );

          log("markers  len is : ${markers.length}");
          update();
          isLoading(false);
        }
      }

      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> addTowishListFunction({placeId}) async {
    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isLoading(true);

      await userService
          .addToWishListMethod(
        userId: userId,
        placeId: placeId,
        status: 1,
      )
          .then((value) {
        if (value!) {
          getPlacesList();
        }
      });

      // isLoading(false);
      update();
    } catch (e) {
      log(e.toString());
    } finally {
      // controller.locateWindowPop(false);
      // isLoading(false);
    }
  }

  Future<void> removeFromWishListFunction({placeId}) async {
    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isLoading(true);
      await userService
          .addToWishListMethod(
        userId: userId,
        placeId: placeId,
        status: 0,
      )
          .then((value) {
        if (value! == true) {
          getPlacesList();
        }
      });

      // isLoading(false);
      update();
    } catch (e) {
      log(e.toString());
    } finally {
      // isLoading(false);
    }
  }

  clearFilterHomeScreenPlacesList() {
    isLoading(true);
    isFiltered.value = false;
    placeFilteredList = [];

    filterProv.updateFilterDataList([]);

    // for (var filter in filteredCatList) {
    //   for (var item inplaceDataList) {
    //     if (filter.id == item.id) {
    //      placeFilteredList.add(item);
    //     }
    //   }
    // }

    if (placeDataList.isNotEmpty) {
      markers.clear();
      selectedPlaceLocation = placeDataList.first;
      for (int i = 0; i < placeDataList.length; i++) {
        // final Uint8List markerIcon =
        //     await getBytesFromAsset(images[i].toString(), 100);

        var singlePlace = placeDataList[i];

        // if (Get.isRegistered<HomeController>()) {
        var bottombarController = Get.find<BottomNavigationBarController>();

        // log(" singlePlace.latitude!.toDouble() ${singlePlace.latitude!.toDouble()}");
        // log(" singlePlace.longitude!.toDouble() ${singlePlace.longitude!.toDouble()}");

        markers.add(
          Marker(
            onTap: () {
              bottombarController.locateWindowPop.value =
                  !bottombarController.locateWindowPop.value;
              selectedPlaceLocation = singlePlace;
            },
            infoWindow: InfoWindow(
                title: singlePlace.placesName, snippet: singlePlace.address),
            flat: true,
            rotation: 1.1,
            zIndex: 10,

            visible: true,

            markerId: MarkerId(singlePlace.id.toString()),
            position: LatLng(
              double.parse(singlePlace.latitude),
              double.parse(singlePlace.longitude),
            ),
            // icon: BitmapDescriptor.fromBytes(markerIcon),
          ),
        );

        log(" markers  len is : ${markers.length}");
      }
    }

    log("placeDataList len ::${placeDataList.length}");
    update();
    isLoading(false);
  }

  addPlanToSelectedDay({placeId}) async {
    if (Get.isRegistered<MyplanController>()) {
      var myplanController = Get.find<MyplanController>();
      PlanService planService = PlanService();
      isLoading(true);
      try {
        bool planAdded = await planService.addPlanToDayMethod(
              placeId: placeId,
              dayNumber: myplanController.selectedDayData!.dayNumber,
            ) ??
            false;
        if (planAdded) {
          Fluttertoast.showToast(
              msg: 'Place Added Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.back();
          myplanController.planDaysGetListFunction();
        } else {
          Fluttertoast.showToast(
            msg: 'Place Not Added.\nPlease try again later',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        update();
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading(false);
      }
    }
  }
}
