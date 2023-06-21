import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/app/modules/bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';
import 'package:playze/app/modules/home/controllers/home_controller.dart';
import 'package:playze/reusability/shared/custom_bottom_bar.dart';
import 'package:playze/reusability/utils/app_colors.dart';
import 'package:playze/reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../controllers/add_places_controller.dart';

class AddplacesView extends GetView<AddPlacesController> {
  const AddplacesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: Get.height * 0.06,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: const Image(
                              image: AssetImage("assets/images/back.png"),
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
                          "Add Places",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SizedBox(
                height: Get.size.height * 0.75,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyColor.withOpacity(0.12),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.07,
                                  child: const Image(
                                    image:
                                        AssetImage("assets/images/search.png"),
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.03),
                                SizedBox(
                                  height: Get.height * 0.3,
                                  width: Get.width * 0.5,
                                  child: const TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: "Search places",
                                      border: InputBorder.none,
                                    ),
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyColor.withOpacity(0.12),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Image.asset("assets/images/menu2.png"),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        itemCount: controller.placeDatalist.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 18);
                        },
                        itemBuilder: (context, index) {
                          var singlePlace = controller.placeDatalist[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            // height: Get.height * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.greyColor.withOpacity(0.12),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 118,
                                      width: 122,
                                      decoration: const BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 118,
                                            width: 122,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: CachedNetworkImage(
                                                imageUrl: controller
                                                    .placeDatalist[index]
                                                    .images
                                                    .first
                                                    .images
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) {
                                                  return const Center(
                                                    child: Text(
                                                      "Image Not Loaded",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            child: SizedBox(
                                              height: Get.height * 0.02,
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/dil.png"),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(controller.placeDatalist[index]
                                                .placesName),
                                            SizedBox(height: Get.height * 0.01),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        "assets/images/star.png"),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Text(
                                                  controller
                                                      .placeDatalist[index]
                                                      .rating,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Text(
                                                  "${controller.placeDatalist[index].totalReview} Reviews",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.01),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        "assets/images/log.png"),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Expanded(
                                                  // width: Get.width * 0.45,
                                                  child: Text(
                                                    controller
                                                        .placeDatalist[index]
                                                        .address,
                                                    maxLines: null,
                                                    style: const TextStyle(
                                                      // overflow: TextOverflow.ellipsis,
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.01),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        "assets/images/walking.png"),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Expanded(
                                                  child: Text(
                                                    "${controller.placeDatalist[index].duration} ${controller.placeDatalist[index].distance} away",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                        if (Get.isRegistered<
                                                HomeController>() &&
                                            Get.isRegistered<
                                                BottomNavigationBarController>()) {
                                          var homeController =
                                              Get.find<HomeController>();
                                          var bottomBarController = Get.find<
                                              BottomNavigationBarController>();
                                          homeController.isMapView.value = true;
                                          homeController.selectedPlaceLocation =
                                              singlePlace;
                                          homeController.initialCameraPosition =
                                              CameraPosition(
                                            target: LatLng(
                                              double.parse(homeController
                                                  .selectedPlaceLocation!
                                                  .latitude),
                                              double.parse(homeController
                                                  .selectedPlaceLocation!
                                                  .longitude),
                                            ),
                                            tilt: 10,
                                            zoom: 14.5,
                                          );

                                          bottomBarController
                                              .selectedIndex.value = 0;
                                          bottomBarController
                                              .locateWindowPop.value = true;
                                        }
                                      },
                                      child: const Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/go.png"),
                                            width: 25,
                                          ),
                                          Text("  Go"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () {
                                        controller.addPlanToSelectedDay(
                                          placeId: singlePlace.id,
                                        );
                                      },
                                      child: const Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/plan.png"),
                                            width: 25,
                                          ),
                                          Text("  My Plan"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: ButtonWithStyle(
                                        onPressed: () {
                                          // Get.toNamed(Routes.FULL_DETAILS);
                                          Get.toNamed(
                                            Routes.FULL_DETAILS,
                                            arguments: [
                                              singlePlace.id,
                                            ],
                                          );
                                        },
                                        textVal: "Details",
                                        // btnwidth: Get.width * 0.3,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: const CustomBottomBar(
        fromOther: true,
      ),
      extendBody: true,
    );
  }
}
