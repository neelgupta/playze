import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_drawer.dart';

import '../../../../reusability/utils/app_colors.dart';
import '../../../../reusability/utils/util.dart';
import '../../../routes/app_pages.dart';
import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  final controller = Get.put<WishlistController>(WishlistController());

  WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Text("Wishlist",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ],
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
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 15,
                        ),
                        // color: Colors.white,
                        height: Get.height * 0.75,
                        width: Get.width,
                        child: controller.wishDataList.isEmpty
                            ? const Center(
                                child: Text(
                                  "You Wishlist is Empty\n\nAdd Some Places",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () {
                                  return controller.getWishListFunction();
                                },
                                child: ListView.separated(
                                  // padding: const EdgeInsets.symmetric(
                                  //   horizontal: 15,
                                  //   vertical: 15,
                                  // ),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.wishDataList.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 10);
                                  },
                                  itemBuilder: (context, index) {
                                    var singleData =
                                        controller.wishDataList[index];
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      // height: Get.height * 0.25,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.greyColor
                                                .withOpacity(0.12),
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
                                                height: Get.height * 0.12,
                                                width: Get.width * 0.4,
                                                decoration: const BoxDecoration(
                                                  color: Colors.cyan,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: singleData
                                                            .images.first.images
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                        height:
                                                            Get.height * 0.12,
                                                        width: Get.width * 0.4,
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return const Center(
                                                            child: Text(
                                                              "Image Not Loaded",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                    Positioned(
                                                      top: 8,
                                                      left: 8,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .removeFromWishListFunction(
                                                            placeId:
                                                                singleData.id,
                                                          );
                                                        },
                                                        child: SizedBox(
                                                          // height: Get.height * 0.02,
                                                          child: Image.asset(
                                                            "assets/images/dil2.png",
                                                            color: AppColors
                                                                .redColor,
                                                            height: 24,
                                                            width: 24,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      singleData.placesName,
                                                      style: const TextStyle(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize: 14,
                                                      ),
                                                      // "Children’s Museum"
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.015),
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
                                                            width: Get.width *
                                                                0.02),
                                                        Text(
                                                          singleData.rating,
                                                          style:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .blackColor,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: Get.width *
                                                                0.02),
                                                        Text(
                                                          "${singleData.totalReview} Reviews",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.015),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.02,
                                                          child: const Image(
                                                            image: AssetImage(
                                                                "assets/images/log.png"),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: Get.width *
                                                                0.02),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.35,
                                                          child: Text(
                                                            singleData.address,
                                                            // "100 Laurier Street, Gatineau..",
                                                            style:
                                                                const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.01),
                                                    // const Row(
                                                    //   children: [
                                                    // SizedBox(
                                                    //   height: Get.height * 0.02,
                                                    //   child: const Image(
                                                    //     image: AssetImage(
                                                    //         "assets/images/walking.png"),
                                                    //   ),
                                                    // ),
                                                    // SizedBox(
                                                    //     width: Get.width * 0.02),
                                                    // Text(
                                                    //   "${singleData.totalReview} min",
                                                    //   style: TextStyle(
                                                    //       fontSize: 12,
                                                    //       color: Colors.grey),
                                                    // ),
                                                    // SizedBox(
                                                    //   width: Get.width * 0.02,
                                                    // ),
                                                    // const Text(
                                                    //   "1 km away",
                                                    //   style: TextStyle(
                                                    //       fontSize: 12,
                                                    //       color: Colors.grey),
                                                    // ),
                                                    //   ],
                                                    // ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: Get.height * 0.015),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .gotoMapPlaceLocation(
                                                    placeId: singleData.id,
                                                  );
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
                                              SizedBox(
                                                  width: Get.width * 0.025),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .addPlanToSelectedDay(
                                                    placeId: singleData.id,
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
                                              ButtonWithStyle(
                                                onPressed: () {
                                                  //   Get.toNamed(Routes.FULL_DETAILS);
                                                  Get.toNamed(
                                                    Routes.FULL_DETAILS,
                                                    arguments: [
                                                      singleData.id,
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
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
      extendBody: true,
    );
  }
}
