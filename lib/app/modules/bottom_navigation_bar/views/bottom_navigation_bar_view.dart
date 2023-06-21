import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/reusability/shared/custom_bottom_bar.dart';
import 'package:playze/reusability/utils/app_colors.dart';
import 'package:playze/reusability/utils/util.dart';
import 'package:playze/app/modules/home/controllers/home_controller.dart';
import 'package:playze/app/modules/home/views/home_view.dart';
import 'package:playze/app/modules/myplan/views/myplan_view.dart';
import 'package:playze/app/modules/profile/views/profile_view.dart';

import '../../../routes/app_pages.dart';
import '../../wishlist/views/wishlist_view.dart';
import '../controllers/bottom_navigation_bar_controller.dart';

// ignore: must_be_immutable
class BottomNavigationbarView extends GetView<BottomNavigationBarController> {
  @override
  var controller = Get.put(BottomNavigationBarController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> screens = [
    HomeView(),
    // const Center(child: Text("WishList")),
    WishlistView(),
    MyplanView(),
    ProfileView(),
  ];

  BottomNavigationbarView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationBarController>(
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          key: scaffoldKey,
          body: Stack(
            children: [
              Obx(
                () => screens.elementAt(controller.selectedIndex.value),
              ),
              Obx(() => controller.selectedIndex.value == 0
                  ? controller.locateWindowPop.value
                      ? GetBuilder<HomeController>(builder: (hController) {
                          return Positioned(
                            bottom: 80,
                            child: SizedBox(
                                height: Get.height * 0.25,
                                width: Get.width,
                                child: Card(
                                  child: Container(
                                    color: Colors.white,
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 0),
                                    height: Get.height * 0.25,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: Get.height * 0.12,
                                              width: Get.width * 0.4,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.65),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl: hController
                                                          .selectedPlaceLocation!
                                                          .images
                                                          .first
                                                          .images,
                                                      height: Get.height * 0.12,
                                                      width: Get.width * 0.4,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                          url, error) {
                                                        log("hController.selectedPlaceLocation!.images.first :${hController.selectedPlaceLocation!.images.first.images}");
                                                        return const Center(
                                                          child: Text(
                                                            "No Image",
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child: SizedBox(
                                                      height: Get.height * 0.02,
                                                      child: const Image(
                                                        image: AssetImage(
                                                          "assets/images/dil.png",
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${hController.selectedPlaceLocation?.placesName}",
                                                    // "Children’s Museum",
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.01),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.02,
                                                        child: const Image(
                                                          image: AssetImage(
                                                              "assets/images/star.png"),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              Get.width * 0.02),
                                                      Text(
                                                        "${hController.selectedPlaceLocation?.rating}",
                                                        // "4.0",
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              Get.width * 0.02),
                                                      Text(
                                                        "${hController.selectedPlaceLocation?.totalReview} Reviews",
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.01),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.02,
                                                        child: const Image(
                                                          image: AssetImage(
                                                            "assets/images/log.png",
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.02,
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              Get.width * 0.35,
                                                          child: Text(
                                                            "${hController.selectedPlaceLocation?.address}",
                                                            // "100 Laurier Street, Gatineau..",
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.01),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.02,
                                                        child: const Image(
                                                          image: AssetImage(
                                                              "assets/images/walking.png"),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.02,
                                                      ),
                                                      const Text(
                                                        "2 min",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.02,
                                                      ),
                                                      const Text(
                                                        "1 km away",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      "assets/images/go.png"),
                                                  width: 25,
                                                ),
                                                Text("  Go"),
                                              ],
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.025,
                                            ),
                                            const Row(
                                              children: [
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
                                                    hController
                                                        .selectedPlaceLocation
                                                        ?.id
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
                                )),
                          );
                        })
                      : const SizedBox()
                  : const SizedBox())
            ],
          ),
          bottomNavigationBar: const CustomBottomBar(),
        );
      },
    );
  }
}
