import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/Reusability/shared/drawer.dart';

import '../../../data/modal/plaseModel.dart';
import '../../../data/service/Userservise.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  var index = 0;
  String action = "Home";
  var isMapView = true.obs;

  RxBool isLoading = false.obs;
  LatLng? positionStream;
  static const LatLng location1 = LatLng(21.230557, 72.821677);
  static const LatLng location2 = LatLng(21.224772, 72.821394);

  Usersevise usersevise = Usersevise();

  PlaceDetails? selectedPlaceLocation;

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
  late Position currentLocation;
  LocationPermission? permission;

  @override
  void onInit() {
    super.onInit();
    getPlasedata();

    loadData();
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

  getUserLocation() async {
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
    print('center  :: $center');
    update();
    isLoading(false);
  }

  loadData() async {
    isLoading(true);
    // locateUser();
    getUserLocation();
  }

  Future<void> getPlasedata() async {
    isLoading(true);
    try {
      await usersevise.getPlasedata().then((value) {
        placeModel = value;
        placeModel?.data?.forEach((element) {
          placeDataList.add(element);
          // lip.add(element.name);
        });
        log("placeDataList len is : ${placeDataList.length}");
      });

      if (placeDataList.isNotEmpty) {
        selectedPlaceLocation = placeDataList.first;
        for (int i = 0; i < placeDataList.length; i++) {
          // final Uint8List markerIcon =
          //     await getBytesFromAsset(images[i].toString(), 100);

          var singlePlace = placeDataList[i];

          // log(" singlePlace.latitude!.toDouble() ${singlePlace.latitude!.toDouble()}");
          // log(" singlePlace.longitude!.toDouble() ${singlePlace.longitude!.toDouble()}");
          markers.add(
            Marker(
              onTap: () {
                controller.locateWindowPop.value =
                    !controller.locateWindowPop.value;
                selectedPlaceLocation = singlePlace;
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

          log("markers  len is : ${markers.length}");
          update();
          // isLoading(false);
        }
      }

      update();
    } catch (e) {
      print(e.toString());
    } finally {}
  }
}
