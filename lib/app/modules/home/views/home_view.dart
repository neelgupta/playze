import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/modules/BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  final controller = Get.put<HomeController>(HomeController());
  final controllerc =
      Get.put<BottomNavigationbarController>(BottomNavigationbarController());

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        key: _key,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: Get.height * 0.1, //
          flexibleSpace: Container(
            height: Get.height * 0.2,
            color: const Color(0xff0264C5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          height: Get.height * 0.06,
                          decoration: const BoxDecoration(),
                          child: Center(
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                child: const Image(
                                  image: AssetImage("assets/images/menu.png"),
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text("Home",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.NOTIFICATIONS);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          height: Get.height * 0.06,
                          decoration: const BoxDecoration(),
                          child: Center(
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                child: const Image(
                                  image: AssetImage("assets/images/beel.png"),
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: const CsDrawer(),
        body: Obx(() => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Obx(
                () => controller.isMapView.value
                    ? Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.85,
                                  width: Get.width,
                                  child: GoogleMap(
                                    initialCameraPosition:
                                        controller.initialCameraPosition!,
                                    myLocationEnabled: true,
                                    scrollGesturesEnabled: true,
                                    zoomControlsEnabled: false,
                                    // myLocationButtonEnabled: true,
                                    markers: Set<Marker>.of(controller.markers),
                                    onTap: (location) {
                                      log("location.latitude ::  ${location.latitude}");
                                      log("location. ::  ${location.longitude}");
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.1,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.SEARCH);
                                      },
                                      child: Container(
                                        height: Get.height * 0.06,
                                        width: Get.width * 0.75,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.03,
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.05,
                                                width: Get.width * 0.07,
                                                child: const Image(
                                                    image: AssetImage(
                                                        "assets/images/search.png"))),
                                            SizedBox(
                                              width: Get.width * 0.03,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.3,
                                              width: Get.width * 0.5,
                                              child: const TextField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                    hintText: "Search places",
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.FILTER);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        height: Get.height * 0.06,
                                        width: Get.width * 0.13,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                            "assets/images/menu2.png"),
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  bottom: 100,
                                  left: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.isMapView.value =
                                          !controller.isMapView.value;
                                      controllerc.locateWindowPop.value = false;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        color: Colors.white,
                                      ),
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.4,
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: Get.width * 0.25,
                                            child: const Text("List View"),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            height: Get.height * 0.05,
                                            width: Get.width * 0.07,
                                            child: Image.asset(
                                                "assets/images/list.png"),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 115,
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.getUserLocation();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: Get.height * 0.09,
                                      width: Get.width * 0.15,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                          "assets/images/location.png"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.1,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.SEARCH);
                                    },
                                    child: Container(
                                      height: Get.height * 0.06,
                                      width: Get.width * 0.75,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          SizedBox(
                                              height: Get.height * 0.05,
                                              width: Get.width * 0.07,
                                              child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/search.png"))),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.3,
                                            width: Get.width * 0.5,
                                            child: const TextField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                  hintText: "Search places",
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.FILTER);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: Get.height * 0.06,
                                      width: Get.width * 0.13,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                          "assets/images/menu2.png"),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                color: Colors.white,
                                height: Get.height * 0.75,
                                width: Get.width,
                                child: ListView.builder(
                                  itemCount: controller.placeDataList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Card(
                                          child: Container(
                                            color: Colors.white,
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 20, 10, 0),
                                            height: Get.height * 0.25,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height:
                                                              Get.height * 0.12,
                                                          width:
                                                              Get.width * 0.4,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.cyan,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                          ),
                                                          // decoration:
                                                          //     BoxDecoration(
                                                          //   borderRadius:
                                                          //       const BorderRadius
                                                          //               .all(
                                                          //           Radius
                                                          //               .circular(
                                                          //                   10)),
                                                          //   image:
                                                          //       DecorationImage(
                                                          //     image:
                                                          //         NetworkImage(
                                                          //       controller
                                                          //           .Data[index]
                                                          //           .logo
                                                          //           .toString(),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: controller
                                                                  .placeDataList[
                                                                      index]
                                                                  .images!
                                                                  .first
                                                                  .images!,
                                                              fit: BoxFit.cover,
                                                              errorWidget:
                                                                  (context, url,
                                                                      error) {
                                                                return const Center(
                                                                  child: Text(
                                                                      "No Image"),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 10,
                                                          left: 10,
                                                          child: SizedBox(
                                                            height: Get.height *
                                                                0.02,
                                                            child: const Image(
                                                                image: AssetImage(
                                                                    "assets/images/dil.png")),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "${controller.placeDataList[index].placesName}"),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          controller
                                                                          .placeDataList[
                                                                              index]
                                                                          .rating !=
                                                                      0 ||
                                                                  controller
                                                                          .placeDataList[
                                                                              index]
                                                                          .totalreview !=
                                                                      0
                                                              ? Row(
                                                                  children: [
                                                                    controller.placeDataList[index].rating !=
                                                                            0
                                                                        ? SizedBox(
                                                                            height: Get.height *
                                                                                0.02,
                                                                            child:
                                                                                const Image(image: AssetImage("assets/images/star.png")))
                                                                        : h(1),
                                                                    controller.placeDataList[index].rating !=
                                                                            0
                                                                        ? SizedBox(
                                                                            width:
                                                                                Get.width * 0.02,
                                                                          )
                                                                        : h(1),
                                                                    controller.placeDataList[index].rating !=
                                                                            0
                                                                        ? Text(
                                                                            "${controller.placeDataList[index].rating}",
                                                                            style:
                                                                                const TextStyle(fontSize: 16),
                                                                          )
                                                                        : h(1),
                                                                    SizedBox(
                                                                      width: Get
                                                                              .width *
                                                                          0.02,
                                                                    ),
                                                                    controller.placeDataList[index].totalreview !=
                                                                            0
                                                                        ? Text(
                                                                            '${controller.placeDataList[index].totalreview}',
                                                                            style:
                                                                                const TextStyle(fontSize: 12, color: Colors.grey),
                                                                          )
                                                                        : h(1),
                                                                    controller.placeDataList[index].totalreview !=
                                                                            0
                                                                        ? const Text(
                                                                            ' Reviews',
                                                                            style:
                                                                                TextStyle(fontSize: 10, color: Colors.grey),
                                                                          )
                                                                        : h(1),
                                                                  ],
                                                                )
                                                              : h(1),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.02,
                                                                  child: const Image(
                                                                      image: AssetImage(
                                                                          "assets/images/log.png"))),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.02,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.35,
                                                                child: Text(
                                                                  "${controller.placeDataList[index].address}",
                                                                  style: const TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.02,
                                                                  child: const Image(
                                                                      image: AssetImage(
                                                                          "assets/images/walking.png"))),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.02,
                                                              ),
                                                              const Text(
                                                                "2 min",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.02,
                                                              ),
                                                              const Text(
                                                                "1 km away",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.025,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        controller.isMapView
                                                            .value = true;
                                                        controller
                                                                .selectedPlaceLocation =
                                                            controller
                                                                    .placeDataList[
                                                                index];
                                                        controller
                                                                .initialCameraPosition =
                                                            CameraPosition(
                                                          target: LatLng(
                                                              double.parse(controller
                                                                  .selectedPlaceLocation!
                                                                  .latitude!),
                                                              double.parse(controller
                                                                  .selectedPlaceLocation!
                                                                  .longitude!)),
                                                          tilt: 10,
                                                          zoom: 14.5,
                                                        );

                                                        controllerc
                                                            .locateWindowPop
                                                            .value = true;
                                                      },
                                                      child: Row(
                                                        children: const [
                                                          Image(
                                                            image: AssetImage(
                                                                "assets/images/go.png"),
                                                            width: 25,
                                                          ),
                                                          Text("  Go"),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.025,
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Image(
                                                          image: AssetImage(
                                                              "assets/images/plan.png"),
                                                          width: 25,
                                                        ),
                                                        Text("  My Plan"),
                                                      ],
                                                    ),
                                                    ButtonWithStyle(
                                                      onPressed: () {
                                                        Get.toNamed(
                                                          Routes.FULL_DETAILS,
                                                          arguments: [
                                                            controller
                                                                .placeModel!
                                                                .data![index]
                                                                .id
                                                          ],
                                                        );
                                                      },
                                                      textVal: "Details",
                                                      btnwidth: Get.width * 0.3,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        h(15)
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 72,
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Colors.white,
                              ),
                              height: Get.height * 0.08,
                              width: Get.width,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.isMapView.value = true;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        color: Colors.white,
                                      ),
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.4,
                                      child: Row(
                                        children: [
                                          Container(
                                              alignment: Alignment.center,
                                              width: Get.width * 0.25,
                                              child: const Text("Map View")),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            height: Get.height * 0.05,
                                            width: Get.width * 0.07,
                                            child: Image.asset(
                                                "assets/images/mapviwe.png"),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
              )));
  }
}
