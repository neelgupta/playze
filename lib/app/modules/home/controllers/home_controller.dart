import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'dart:ui' as ui;

import '../../../data/modal/plaseModel.dart';
import '../../../data/service/Userservise.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  var index = 0;
  String action = "Home";
  var ison = false.obs;

  RxBool isLoading = false.obs;
  LocationData? currentlocation;
  static const LatLng location1 = LatLng(21.230557, 72.821677);
  static const LatLng location2 = LatLng(21.224772, 72.821394);
  Usersevise usersevise = Usersevise();
  List<String> images = [ 'assets/images/NoPath.png' ,'assets/images/NoPath.png', 'assets/images/NoPath.png' , 'assets/images/NoPath.png', 'assets/images/NoPath.png' , 'assets/images/NoPath.png' ,];
  Uint8List? markerImage;
  PlaseModel? a;
  final List<Marker> markers =  <Marker>[];
  final List<LatLng> latLang =  <LatLng>[
    LatLng(21.194198910486286, 72.78706006722157), LatLng(21.19339957816572, 72.78677048041395) ,LatLng(21.19302105335981, 72.78770875175347),
    LatLng(21.192499528705643, 72.78736592184096), LatLng(21.191952767011255, 72.78837636789889), LatLng(21.191935943542433, 72.7884124552581)];
  BitmapDescriptor icons = BitmapDescriptor.defaultMarker;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getcurrentlocation(){
    Location location = Location();

    location.getLocation().then((location){
      currentlocation = location;
    });
  }

  // void setcoustommarkerIcon(){
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/images/NoPath.png",mipmaps: true).then((icon){
  //     icons = icon;
  //   });
  // }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  loadData()async{
    isLoading(true);
    for(int i = 0 ; i < latLang.length ; i++) {
      final Uint8List markerIcon = await getBytesFromAsset(images[i].toString(), 100);
      markers.add(Marker(
        onTap: (){
          controller.Dpop.value = !controller.Dpop.value;
        },
        markerId: MarkerId(i.toString()),
        position: latLang[i],
        icon: BitmapDescriptor.fromBytes(markerIcon),
      ));
      update();
      isLoading(false);
    }
  }

  Future<void> getAbout() async {
    isLoading(true);
    try {
      a = await usersevise.getPlasedata();
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

}