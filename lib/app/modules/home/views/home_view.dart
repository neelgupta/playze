import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/app/modules/BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:provider/provider.dart';

import '../../../data/provider/filter_provider.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_view_widgets.dart';

class HomeView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  final controller = Get.put<HomeController>(HomeController());
  final controllerc =
      Get.put<BottomNavigationbarController>(BottomNavigationbarController());

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    controller.searchController.text = filterProvider.searchString;
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
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : controller.isMapView.value
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
                              child: GetBuilder<HomeController>(
                                  builder: (context) {
                                return GoogleMap(
                                  initialCameraPosition:
                                      controller.initialCameraPosition!,
                                  // myLocationEnabled: true,
                                  // buildingsEnabled: true,
                                  // mapToolbarEnabled: true,
                                  // myLocationButtonEnabled: true,

                                  // zoomGesturesEnabled: true,
                                  rotateGesturesEnabled: false,
                                  scrollGesturesEnabled: true,
                                  zoomControlsEnabled: false,
                                  // myLocationButtonEnabled: true,
                                  // tiltGesturesEnabled: true,
                                  compassEnabled: false,

                                  markers: Set<Marker>.of(controller.markers),
                                  onTap: (location) {
                                    // log("location.latitude ::  ${location.latitude}");
                                    // log("location. ::  ${location.longitude}");
                                    controllerc.locateWindowPop.value = false;
                                  },
                                  // onCameraMove: (func) {
                                  //   // log("location.latitude ::  ${location.latitude}");
                                  //   // log("location. ::  ${location.longitude}");
                                  //   controllerc.locateWindowPop.value = false;
                                  // },
                                );
                              }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: Get.height * 0.1),
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
                                        Radius.circular(25),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: Get.width * 0.03),
                                        SizedBox(
                                            height: Get.height * 0.05,
                                            width: Get.width * 0.07,
                                            child: const Image(
                                                image: AssetImage(
                                                    "assets/images/search.png"))),
                                        SizedBox(width: Get.width * 0.03),
                                        SizedBox(
                                          height: Get.height * 0.3,
                                          width: Get.width * 0.5,
                                          child: TextFormField(
                                            enabled: false,
                                            controller:
                                                controller.searchController,
                                            decoration: const InputDecoration(
                                              hintText: "Search places",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.FILTER);
                                  },
                                  child: filterProvider.filterCategoryCount == 0
                                      ? Container(
                                          padding: const EdgeInsets.all(10),
                                          height: Get.height * 0.06,
                                          width: Get.width * 0.13,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                              "assets/images/menu2.png"),
                                        )
                                      : Badge(
                                          label: Text(
                                              "${filterProvider.filterCategoryCount}"),
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
                                    border:
                                        Border.all(color: Colors.blueAccent),
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
                                  child:
                                      Image.asset("assets/images/location.png"),
                                ),
                              ),
                            ),
                            // if (controller.isFiltered.value)
                            //   Positioned(
                            //     top: 75,
                            //     right: 15,
                            //     child: GestureDetector(
                            //       onTap: () {
                            //         // controller.getUserLocation();
                            //         controller
                            //             .clearFilterHomeScreenPlacesList();
                            //       },
                            //       child: Container(
                            //         height: 35,
                            //         // width: 120,
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 15),
                            //         decoration: const BoxDecoration(
                            //           color: AppColors.lightPrimaryColor,
                            //           borderRadius:
                            //               BorderRadius.all(Radius.circular(20)),
                            //         ),
                            //         child: const Center(
                            //           child: Text(
                            //             "Clear Filter",
                            //             style: TextStyle(
                            //               color: AppColors.whiteColor,
                            //               fontSize: 15,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
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
                                  child:
                                      Image.asset("assets/images/location.png"),
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
                                      SizedBox(width: Get.width * 0.03),
                                      SizedBox(
                                        height: Get.height * 0.05,
                                        width: Get.width * 0.07,
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/search.png"),
                                        ),
                                      ),
                                      SizedBox(width: Get.width * 0.03),
                                      SizedBox(
                                        height: Get.height * 0.3,
                                        width: Get.width * 0.5,
                                        child: TextFormField(
                                          enabled: false,
                                          controller:
                                              controller.searchController,
                                          decoration: const InputDecoration(
                                            hintText: "Search places",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width * 0.02),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.FILTER);
                                },
                                child: filterProvider.filterCategoryCount == 0
                                    ? Container(
                                        padding: const EdgeInsets.all(10),
                                        height: Get.height * 0.06,
                                        width: Get.width * 0.13,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                            "assets/images/menu2.png"),
                                      )
                                    : Badge(
                                        label: Text(
                                            "${filterProvider.filterCategoryCount}"),
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
                                      ),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            color: Colors.white,
                            height: Get.height * 0.72,
                            width: Get.width,
                            child: GetBuilder<HomeController>(
                              builder: (context) {
                                return controller.isFiltered.value
                                    ? controller.placeFilteredList.isEmpty
                                        ? const Center(
                                            child: Text("No data Available"),
                                          )
                                        : ListView.builder(
                                            itemCount: controller
                                                .placeFilteredList.length,
                                            itemBuilder: (context, index) {
                                              return SinglePlaceWidget(
                                                placeData: controller
                                                    .placeFilteredList[index],
                                              );
                                            },
                                          )
                                    : RefreshIndicator(
                                        onRefresh: () {
                                          return controller.getPlasedata();
                                        },
                                        child: ListView.builder(
                                          itemCount:
                                              controller.placeDataList.length,
                                          itemBuilder: (context, index) {
                                            return SinglePlaceWidget(
                                              placeData: controller
                                                  .placeDataList[index],
                                            );
                                          },
                                        ),
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
                                    border:
                                        Border.all(color: Colors.blueAccent),
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
      ),
    );
  }
}
