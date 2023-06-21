import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/Reusability/shared/custom_drawer.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/reusability/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../reusability/utils/util.dart';
import '../../../data/provider/filter_provider.dart';
import '../../bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_view_widgets.dart';

class HomeView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  final controller = Get.put<HomeController>(HomeController());
  final bottomController =
      Get.put<BottomNavigationBarController>(BottomNavigationBarController());

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    controller.searchController.text = filterProvider.searchString;
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
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
                        bottomController.locateWindowPop.value = false;
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
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
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
                            ),
                          ),
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
      drawer: const CustomStartDrawer(),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : controller.permission! == LocationPermission.whileInUse ||
                    controller.permission! == LocationPermission.always
                ? controller.isMapView.value
                    ? SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.85,
                                  width: Get.width,
                                  child: controller.permission! ==
                                              LocationPermission.whileInUse ||
                                          controller.permission! ==
                                              LocationPermission.always
                                      ? GetBuilder<HomeController>(
                                          builder: (context) {
                                          return GoogleMap(
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: controller.center!,
                                              tilt: 10,
                                              zoom: controller.permission! ==
                                                          LocationPermission
                                                              .whileInUse ||
                                                      controller.permission! ==
                                                          LocationPermission
                                                              .always
                                                  ? 14.5
                                                  : 4.5,
                                              // tilt: 10,
                                              // zoom: 14.5,
                                            ),

                                            // zoomGesturesEnabled: true,
                                            rotateGesturesEnabled: false,
                                            scrollGesturesEnabled: true,
                                            zoomControlsEnabled: false,
                                            // myLocationButtonEnabled: true,
                                            tiltGesturesEnabled: false,
                                            compassEnabled: false,
                                            onMapCreated: (gcontrol) {
                                              controller.gMapController =
                                                  gcontrol;
                                            },
                                            markers: Set<Marker>.of(
                                                controller.markers),
                                            onTap: (location) {
                                              bottomController.locateWindowPop
                                                  .value = false;
                                              // log("location.latitude ::  ${location.latitude}");
                                              // log("location. ::  ${location.longitude}");
                                            },
                                          );
                                        })
                                      : const Center(
                                          child: Text(
                                            "Allow location permission in your settings",
                                            style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
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
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.85),
                                          borderRadius: const BorderRadius.all(
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
                                                decoration:
                                                    const InputDecoration(
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
                                      child: filterProvider
                                                  .filterCategoryCount ==
                                              0
                                          ? Container(
                                              padding: const EdgeInsets.all(10),
                                              height: Get.height * 0.06,
                                              width: Get.width * 0.13,
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.85),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.asset(
                                                  "assets/images/menu2.png"),
                                            )
                                          : Badge(
                                              label: Text(
                                                  "${filterProvider.filterCategoryCount}"),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                height: Get.height * 0.06,
                                                width: Get.width * 0.13,
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.85),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.asset(
                                                    "assets/images/menu2.png"),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: 15,
                                  bottom: Get.size.height * 0.115,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.isMapView.value =
                                          !controller.isMapView.value;
                                      bottomController.locateWindowPop.value =
                                          false;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        color: Colors.white.withOpacity(0.85),
                                      ),
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.4,
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: Get.width * 0.25,
                                            child: const Text(
                                              "List View",
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            height: Get.height * 0.05,
                                            width: Get.width * 0.07,
                                            child: Image.asset(
                                              "assets/images/list.png",
                                            ),
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
                                  bottom: Get.size.height * 0.11,
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.requestLocationPermission();
                                      controller.goToMyCurrentLocation();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: Get.height * 0.09,
                                      width: Get.width * 0.15,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.85),
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                          "assets/images/location.png"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                              "assets/images/menu2.png",
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Stack(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  // color: Colors.white,
                                  height: Get.height * 0.68,
                                  width: Get.width,
                                  child: GetBuilder<HomeController>(
                                    builder: (context) {
                                      return controller.isFiltered.value
                                          ? controller.placeFilteredList.isEmpty
                                              ? const Center(
                                                  child:
                                                      Text("No data Available"),
                                                )
                                              : ListView.separated(
                                                  itemCount: controller
                                                      .placeFilteredList.length,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return h(15);
                                                  },
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SinglePlaceWidget(
                                                      placeData: controller
                                                              .placeFilteredList[
                                                          index],
                                                    );
                                                  },
                                                )
                                          : RefreshIndicator(
                                              onRefresh: () {
                                                return controller
                                                    .getPlacesList();
                                              },
                                              child: ListView.separated(
                                                itemCount: controller
                                                    .placeDataList.length,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) {
                                                  return h(15);
                                                },
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
                                Positioned(
                                  left: 15,
                                  bottom: Get.size.height * 0.033,
                                  child: GestureDetector(
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
                                            child: const Text("Map View"),
                                          ),
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
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                : const Center(
                    child: Text(
                      "Allow location permission in your settings",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
      ),
    );
  }
}
