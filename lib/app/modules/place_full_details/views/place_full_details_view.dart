// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:playze/reusability/utils/app_colors.dart';
import 'package:playze/app/modules/home/controllers/home_controller.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../../reusability/shared/custom_bottom_bar.dart';
import '../../../../reusability/utils/util.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';
import '../controllers/place_full_details_controller.dart';

class PlaceFullDetailsView extends GetView<PlaceFullDetailsController> {
  const PlaceFullDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    return Scaffold(
      bottomNavigationBar: const CustomBottomBar(fromOther: true),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      icon: Image.asset(
                        "assets/images/back.png",
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () {
                        // Do something
                        Get.back();
                      },
                    ),
                    leadingWidth: 55,
                    titleSpacing: 10,
                    title: const Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    // toolbarHeight: 100,
                    centerTitle: false,
                    expandedHeight: Get.height * 0.32,
                    floating: false,
                    pinned: true,
                    snap: false,
                    elevation: 0,
                    actions: [
                      Container(
                        margin: const EdgeInsets.only(right: 5, top: 5),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: Image.asset(
                            "assets/images/dil.png",
                            height: 20,
                            width: 20,
                          ),
                          onPressed: () {
                            // log("favourite butto tapped");
                            // controller.addTowishListFunction(
                            //   placeId: controller.placeData!.data.id,
                            // );
                            controller.removeFromWishListFunction(
                              placeId: controller.placeData!.data.id,
                            );
                          },
                        ),
                      ),
                    ],
                    backgroundColor: AppColors.primaryColor,
                    flexibleSpace: FlexibleSpaceBar(
                        background: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1,
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                      ),
                      items: controller.placeData!.data.images.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return CachedNetworkImage(
                              imageUrl: i.images,
                              height: Get.height * 0.35,
                              width: Get.width,
                              // progressIndicatorBuilder:
                              //     (context, url, downloadProgress) =>
                              //         Center(
                              //   child: SizedBox(
                              //     height: 30,
                              //     width: 30,
                              //     child: CircularProgressIndicator(
                              //         strokeWidth: 3,
                              //         value: downloadProgress.progress),
                              //   ),
                              // ),
                              fadeInDuration: const Duration(milliseconds: 500),
                              fit: BoxFit.fill,
                              // color: AppColors.primaryColor,
                              errorWidget: (context, url, error) {
                                return const Center(
                                  child: Text(
                                    "Image Not Loaded",
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }).toList(),
                    )
                        // background: CardSwiper(
                        //   // direction: CardSwiperDirection.right,
                        //   cardsCount: controller.placeData!.data.images.length,
                        //   numberOfCardsDisplayed:
                        //       controller.placeData!.data.images.length,
                        //   //  controller.placeData!.data.images.isNotEmpty
                        //   //     ?
                        //   // : 1,
                        //   // isLoop: true,
                        //   // : SwiperLayout.DEFAULT,
                        //   // viewportFraction: 1.2,
                        //   // pagination: const SwiperPagination(
                        //   //   margin: EdgeInsets.only(bottom: 15),
                        //   // ),
                        //   // autoplayDelay: 2500,
                        //   // containerHeight: Get.height * 0.34,

                        //   // autoplay: true,
                        //   cardBuilder: (BuildContext context, int index) {
                        //     var imageUrl =
                        //         controller.placeData!.data.images[index].images;

                        //     log("imageUrl :: $imageUrl");
                        //     return SizedBox(
                        //       height: Get.height * 0.33,
                        //       // height: Get.height * 0.25,
                        //       width: Get.width,
                        //       child: CachedNetworkImage(
                        //         imageUrl: imageUrl,
                        //         // progressIndicatorBuilder:
                        //         //     (context, url, downloadProgress) =>
                        //         //         Center(
                        //         //   child: SizedBox(
                        //         //     height: 30,
                        //         //     width: 30,
                        //         //     child: CircularProgressIndicator(
                        //         //         strokeWidth: 3,
                        //         //         value: downloadProgress.progress),
                        //         //   ),
                        //         // ),
                        //         fadeInDuration: const Duration(milliseconds: 500),
                        //         fit: BoxFit.fill,
                        //         // color: AppColors.primaryColor,
                        //         errorWidget: (context, url, error) {
                        //           return const Center(
                        //             child: Text(
                        //               "Image Not Loaded",
                        //               style: TextStyle(
                        //                 color: AppColors.whiteColor,
                        //                 fontSize: 13,
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //       ),

                        //       // Image.network(
                        //       //     "${controller.placeData?.data.images[index].images.toString()}",
                        //       //     fit: BoxFit.fill),
                        //     );
                        //   },
                        // ),
                        ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.whiteColor,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                              homeController.isMapView.value =
                                                  true;

                                              for (var item in homeController
                                                  .placeDataList) {
                                                if (item.id ==
                                                    controller
                                                        .placeData!.data.id) {
                                                  homeController
                                                          .selectedPlaceLocation =
                                                      item;
                                                  homeController
                                                          .initialCameraPosition =
                                                      CameraPosition(
                                                    target: LatLng(
                                                        double.parse(homeController
                                                            .selectedPlaceLocation!
                                                            .latitude),
                                                        double.parse(homeController
                                                            .selectedPlaceLocation!
                                                            .longitude)),
                                                    tilt: 10,
                                                    zoom: 14.5,
                                                  );

                                                  var bottomC = Get.find<
                                                      BottomNavigationBarController>();

                                                  bottomC.locateWindowPop
                                                      .value = true;
                                                }
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
                                          SizedBox(
                                            width: Get.width * 0.025,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.addPlanToSelectedDay(
                                                placeId: controller
                                                    .placeData?.data.id,
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
                                          InkWell(
                                            onTap: () {
                                              controller
                                                  .addWorkSpaceToMyWorkSpace(
                                                placeId: controller
                                                    .placeData!.data.id,
                                                status: "1",
                                              );
                                            },
                                            child: const Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      "assets/images/plus.png"),
                                                  width: 25,
                                                ),
                                                Text("  Playze Workspace"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.03),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${controller.placeData?.data.placesName}",
                                          style: const TextStyle(fontSize: 22),
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.01),
                                      // Align(
                                      //   alignment: Alignment.topLeft,
                                      //   child: RatingBar.builder(
                                      //     itemSize: 20,
                                      //     initialRating: 3.5,
                                      //     minRating: 0.5,
                                      //     direction: Axis.horizontal,
                                      //     allowHalfRating: true,
                                      //     itemCount: 5,
                                      //     itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                      //     itemBuilder: (context, _) => Icon(
                                      //       Icons.star,
                                      //       size: 16,
                                      //       color: Colors.amber,
                                      //     ),
                                      //     onRatingUpdate: (rating) {
                                      //        rating.toInt() == controller.a?.data?.totalRating;
                                      //        log(object)
                                      //     },
                                      //   ),
                                      // ),
                                      Row(
                                        children: [
                                          IgnorePointer(
                                            ignoring: false,
                                            child: SmoothStarRating(
                                              allowHalfRating: true,
                                              color: Colors.amber,
                                              borderColor: Colors.amber,
                                              rating: double.parse(
                                                controller
                                                    .placeData!.data.avgRating,
                                              ),
                                              size: 20,
                                              starCount: 5,
                                              // isReadOnly: true,

                                              defaultIconData:
                                                  Icons.star_outline_rounded,
                                              filledIconData:
                                                  Icons.star_rounded,
                                              halfFilledIconData:
                                                  Icons.star_half_rounded,
                                            ),
                                          ),
                                          w(10),
                                          Text(
                                            double.parse(controller
                                                    .placeData!.data.avgRating)
                                                .toStringAsFixed(1),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${controller.placeData?.data.description}",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Obx(
                                        () => controller.tabon.value == true
                                            ? const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Highlights",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              )
                                            : const SizedBox(height: 10),
                                      ),
                                      Obx(
                                        () => controller.tabon.value == true
                                            ? ListView.separated(
                                                shrinkWrap: true,
                                                itemCount: controller.placeData!
                                                    .data.highlights.length,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const SizedBox(
                                                      height: 10);
                                                },
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 7,
                                                        width: 7,
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: AppColors
                                                              .primaryColor,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "${controller.placeData?.data.highlights[index].highlights}",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            : const SizedBox(),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                          onTap: () {
                                            controller.tabon.value =
                                                !controller.tabon.value;
                                            log("controller.tabon.value : ${controller.tabon.value}");
                                          },
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              controller.tabon.value
                                                  ? "Read Less"
                                                  : "Read More",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueAccent),
                                            ),
                                          )),
                                      SizedBox(height: Get.height * 0.02),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Images",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      h(10),
                                      SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const PageScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 0),
                                          itemCount: controller
                                              .placeData!.data.images.length,
                                          separatorBuilder: (context, index) {
                                            return w(10);
                                          },
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.REVIEW_IMAGES,
                                                      arguments: [
                                                        controller
                                                            .placeData
                                                            ?.data
                                                            .images[index]
                                                            .images,
                                                      ],
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 105,
                                                    width: Get.width * 0.43,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(20),
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "${controller.placeData?.data.images[index].images}",
                                                        fit: BoxFit.fill,
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return Container(
                                                            color: AppColors
                                                                .greyColor
                                                                .withOpacity(
                                                                    0.45),
                                                            child: const Center(
                                                              child: Text(
                                                                "Image Not Loaded",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontSize: 11,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                h(5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    "${controller.placeData?.data.images[index].imagesTitle}",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      h(10),
                                      const Text(
                                        "Videos",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      h(10),
                                      SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const PageScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 0),
                                          itemCount: controller
                                              .placeData!.data.video.length,
                                          separatorBuilder: (context, index) {
                                            return w(10);
                                          },
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.REVIEW_VIDEOS,
                                                      arguments: [
                                                        controller
                                                            .placeData
                                                            ?.data
                                                            .video[index]
                                                            .video,
                                                      ],
                                                    );
                                                  },
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height: 105,
                                                        width: Get.width * 0.43,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(20),
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(20),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "${controller.placeData?.data.video[index].videoImage}",
                                                            fit: BoxFit.fill,
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              return Container(
                                                                color: AppColors
                                                                    .greyColor
                                                                    .withOpacity(
                                                                        0.45),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    "Video Image Not Loaded",
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .blackColor,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Image.asset(
                                                          "assets/images/play.png",
                                                          height: 28,
                                                          width: 28,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                h(5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    "${controller.placeData?.data.video[index].videoTitle}",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      h(5),
                                      const Divider(),
                                      h(10),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.05,
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Cost",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              w(20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        "For Adults      :",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      w(10),
                                                      Text(
                                                        "\$ ${controller.placeData?.data.costAdults}",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Colors.blueAccent,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        "For Children   :",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      w(10),
                                                      Text(
                                                        "\$ ${controller.placeData?.data.costChildren}",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Colors.blueAccent,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              // w(5),
                                              // Column(
                                              //   children: [
                                              //     Text(
                                              //       "\$ ${controller.placeData?.data.costAdults}",
                                              //       style: const TextStyle(
                                              //           fontSize: 18,
                                              //           color:
                                              //               Colors.blueAccent),
                                              //     ),
                                              //     Text(
                                              //       "\$ ${controller.placeData?.data.costChildren}",
                                              //       style: const TextStyle(
                                              //           fontSize: 18,
                                              //           color:
                                              //               Colors.blueAccent),
                                              //     )
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      h(10),
                                      const Divider(),
                                      h(10),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: Image.asset(
                                                    "assets/images/phone.png"),
                                              ),
                                              w(15),
                                              Text(
                                                "${controller.placeData?.data.contactNo}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          h(18),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: Image.asset(
                                                    "assets/images/mapyellow.png"),
                                              ),
                                              w(15),
                                              SizedBox(
                                                  width: Get.width * 0.7,
                                                  child: Text(
                                                    "${controller.placeData?.data.address}",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ))
                                            ],
                                          ),
                                          h(18),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: Image.asset(
                                                    "assets/images/time.png"),
                                              ),
                                              w(15),
                                              Text(
                                                "${controller.placeData?.data.time}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                h(20),
                                Stack(
                                  children: [
                                    Container(
                                      height: 170,
                                      width: Get.width,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/map_02.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: controller.placeLocation!,
                                          tilt: 10,
                                          zoom: 14.5,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 15,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.openLocInMap(
                                            lat: controller
                                                .placeLocation!.latitude,
                                            lon: controller
                                                .placeLocation!.longitude,
                                            locationName: controller
                                                .placeData!.data.placesName,
                                          );
                                        },
                                        child: SizedBox(
                                          height: Get.height * 0.05,
                                          width: Get.width * 0.08,
                                          child: Image.asset(
                                            "assets/images/blueback.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -10,
                                      right: 20,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        height: Get.height * 0.11,
                                        width: Get.width * 0.1,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                          "assets/images/Block.png",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // h(10),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Rating & Reviews",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          ButtonWithStyle(
                                            onPressed: () {
                                              Get.toNamed(
                                                Routes.WRITEAREVIEW,
                                                arguments: [
                                                  controller.placeData!.data.id,
                                                ],
                                              );
                                            },
                                            textVal: "Add Reviews",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.whiteColor,
                                            ),
                                            btnwidth: Get.width * 0.25,
                                          ),
                                        ],
                                      ),
                                      h(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Total Ratings",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    h(5),
                                                    Text(
                                                      "${controller.placeData?.data.totalRating}",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 26),
                                                    ),
                                                  ],
                                                ),
                                                h(20),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Avg Rating",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.04,
                                                          width:
                                                              Get.width * 0.05,
                                                          child: Image.asset(
                                                            "assets/images/star.png",
                                                          ),
                                                        ),
                                                        w(5),
                                                        Text(
                                                          double.parse(controller
                                                                  .placeData!
                                                                  .data
                                                                  .avgRating)
                                                              .toStringAsFixed(
                                                                  1),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 26,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const VerticalDivider(
                                            width: 10,
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    LinearPercentIndicator(
                                                      isRTL: true,
                                                      addAutomaticKeepAlive:
                                                          true,
                                                      width: Get.width * 0.42,
                                                      lineHeight: 8.0,
                                                      percent: controller
                                                              .placeData!
                                                              .data
                                                              .totalRatingFive /
                                                          100,
                                                      progressColor:
                                                          Colors.amber,
                                                    ),
                                                    const Text("5 Star",
                                                        style: TextStyle(
                                                            color: Colors.grey))
                                                  ],
                                                ),
                                                h(10),
                                                Row(
                                                  children: [
                                                    LinearPercentIndicator(
                                                      isRTL: true,
                                                      addAutomaticKeepAlive:
                                                          true,
                                                      width: Get.width * 0.42,
                                                      lineHeight: 8.0,
                                                      percent: controller
                                                              .placeData!
                                                              .data
                                                              .totalRatingFour /
                                                          100,
                                                      progressColor:
                                                          Colors.amber,
                                                    ),
                                                    const Text("4 Star",
                                                        style: TextStyle(
                                                            color: Colors.grey))
                                                  ],
                                                ),
                                                h(10),
                                                Row(
                                                  children: [
                                                    LinearPercentIndicator(
                                                      isRTL: true,
                                                      addAutomaticKeepAlive:
                                                          true,
                                                      width: Get.width * 0.42,
                                                      lineHeight: 8.0,
                                                      percent: controller
                                                              .placeData!
                                                              .data
                                                              .totalRatingThree /
                                                          100,
                                                      progressColor:
                                                          Colors.amber,
                                                    ),
                                                    const Text("3 Star",
                                                        style: TextStyle(
                                                            color: Colors.grey))
                                                  ],
                                                ),
                                                h(10),
                                                Row(
                                                  children: [
                                                    LinearPercentIndicator(
                                                      isRTL: true,
                                                      addAutomaticKeepAlive:
                                                          true,
                                                      width: Get.width * 0.42,
                                                      lineHeight: 8.0,
                                                      percent: controller
                                                              .placeData!
                                                              .data
                                                              .totalRatingTwo /
                                                          100,
                                                      progressColor:
                                                          Colors.amber,
                                                    ),
                                                    const Text("2 Star",
                                                        style: TextStyle(
                                                            color: Colors.grey))
                                                  ],
                                                ),
                                                h(10),
                                                Row(
                                                  children: [
                                                    LinearPercentIndicator(
                                                      isRTL: true,
                                                      addAutomaticKeepAlive:
                                                          true,
                                                      width: Get.width * 0.42,
                                                      lineHeight: 8.0,
                                                      percent: controller
                                                              .placeData!
                                                              .data
                                                              .totalRatingOne /
                                                          100,
                                                      progressColor:
                                                          Colors.amber,
                                                    ),
                                                    const Text(
                                                      "1 Star",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                h(10),
                                DefaultTabController(
                                  length: 3, // length of tabs
                                  initialIndex: 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      const TabBar(
                                        labelColor: Color(0xffFE7702),
                                        indicatorColor: Colors.transparent,
                                        padding: EdgeInsets.only(right: 100),
                                        unselectedLabelColor: Colors.grey,
                                        unselectedLabelStyle:
                                            TextStyle(fontSize: 12),
                                        labelStyle: TextStyle(fontSize: 16),
                                        tabs: [
                                          Tab(
                                            text: 'Reviews',
                                          ),
                                          Tab(text: 'Images'),
                                          Tab(text: 'Videos'),
                                        ],
                                      ),
                                      Container(
                                        height: Get.height *
                                            0.72, //height of TabBarView
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        child: TabBarView(
                                          children: <Widget>[
                                            Container(
                                                height: Get.height,
                                                width: Get.width,
                                                margin: const EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      controller.reviewAllData ==
                                                              null
                                                          ? const SizedBox(
                                                              height: 150,
                                                              width: double
                                                                  .infinity,
                                                              child: Center(
                                                                child: Text(
                                                                    "No Reviews"),
                                                              ),
                                                            )
                                                          : controller
                                                                  .reviewAllData!
                                                                  .review
                                                                  .isEmpty
                                                              ? const SizedBox(
                                                                  height: 200,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Text(
                                                                      "No Reviews"),
                                                                )
                                                              : ListView
                                                                  .separated(
                                                                  shrinkWrap:
                                                                      true,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  itemCount: controller
                                                                          .viewMoreReviews
                                                                          .value
                                                                      ? controller
                                                                          .reviewAllData!
                                                                          .review
                                                                          .length
                                                                      : controller
                                                                          .reviewsCount,
                                                                  separatorBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return const SizedBox();
                                                                  },
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    var singleReview =
                                                                        controller
                                                                            .reviewAllData!
                                                                            .review[index];
                                                                    return Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.toNamed(
                                                                              Routes.REVIEW_IMAGES,
                                                                              arguments: [
                                                                                singleReview.profileImage,
                                                                                true,
                                                                              ],
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                                            height:
                                                                                Get.height * 0.1,
                                                                            width:
                                                                                Get.width * 0.15,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            // child: Image.asset("assets/images/profilepic.png"),
                                                                            child:
                                                                                CircleAvatar(
                                                                              backgroundColor: AppColors.greyColor.withOpacity(0.25),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: singleReview.profileImage,
                                                                                fit: BoxFit.cover,
                                                                                errorWidget: (context, url, error) {
                                                                                  return const Center(
                                                                                      child: Text(
                                                                                    "No Image",
                                                                                    style: TextStyle(
                                                                                      fontSize: 9,
                                                                                      color: AppColors.blackColor,
                                                                                    ),
                                                                                  ));
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        w(20),
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 20),
                                                                            // height: Get.height *
                                                                            //     0.35,
                                                                            width:
                                                                                Get.width * 0.7,
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: IgnorePointer(
                                                                                    ignoring: true,
                                                                                    child: RatingBar.builder(
                                                                                      itemSize: 20,
                                                                                      initialRating: double.parse(singleReview.rating),
                                                                                      minRating: 1,
                                                                                      direction: Axis.horizontal,
                                                                                      allowHalfRating: true,
                                                                                      itemCount: 5,
                                                                                      glow: false,
                                                                                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                                                      itemBuilder: (context, _) => const Icon(
                                                                                        Icons.star,
                                                                                        size: 16,
                                                                                        color: Colors.amber,
                                                                                      ),
                                                                                      onRatingUpdate: (rating) {
                                                                                        log("rating : $rating");
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                h(5),
                                                                                Text(
                                                                                  singleReview.userNameReviewDate,
                                                                                  // "by Darryl McKinnon on April 22, 2020",
                                                                                  style: const TextStyle(fontSize: 14),
                                                                                ),
                                                                                h(5),
                                                                                Text(
                                                                                  singleReview.review,
                                                                                  // "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum...",
                                                                                  style: const TextStyle(fontSize: 10),
                                                                                ),
                                                                                h(15),
                                                                                singleReview.files.isEmpty
                                                                                    ? const SizedBox()
                                                                                    : SizedBox(
                                                                                        width: Get.width * 0.7,
                                                                                        height: Get.height * 0.1,
                                                                                        // color: AppColors.greyColor,
                                                                                        child: ListView.separated(
                                                                                          shrinkWrap: true,
                                                                                          scrollDirection: Axis.horizontal,
                                                                                          padding: const EdgeInsets.symmetric(),
                                                                                          itemCount: singleReview.files.length,
                                                                                          separatorBuilder: (context, index) {
                                                                                            return const SizedBox(width: 8);
                                                                                          },
                                                                                          itemBuilder: (context, index) {
                                                                                            var singleImage = singleReview.files[index];

                                                                                            return GestureDetector(
                                                                                              onTap: () {
                                                                                                Get.toNamed(
                                                                                                  Routes.REVIEW_IMAGES,
                                                                                                  arguments: [
                                                                                                    singleReview.profileImage,
                                                                                                    true,
                                                                                                  ],
                                                                                                );
                                                                                              },
                                                                                              child: SizedBox(
                                                                                                width: 130.0,
                                                                                                height: 84.0,
                                                                                                child: ClipRRect(
                                                                                                  borderRadius: const BorderRadius.all(
                                                                                                    Radius.circular(10),
                                                                                                  ),
                                                                                                  child: CachedNetworkImage(
                                                                                                    imageUrl: singleImage.files,
                                                                                                    fit: BoxFit.cover,
                                                                                                    errorWidget: (context, url, error) {
                                                                                                      return Container(
                                                                                                        color: AppColors.greyColor.withOpacity(0.45),
                                                                                                        child: const Center(
                                                                                                          child: Text(
                                                                                                            "Image\nNot Loaded",
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(
                                                                                                              color: AppColors.blackColor,
                                                                                                              fontSize: 12,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ),

                                                                                                  // VTImageView(
                                                                                                  //   assetPlaceHolder: singleVideo.videoThumbnail,
                                                                                                  //   // singleVideo.video,
                                                                                                  //   color: AppColors.greyColor,
                                                                                                  //   videoUrl: singleVideo.video,
                                                                                                  //   width: 130.0,
                                                                                                  //   height: 84.0,
                                                                                                  //   errorBuilder: (context, error, stack) {
                                                                                                  //     return Container(
                                                                                                  //       width: 130.0,
                                                                                                  //       height: 84.0,
                                                                                                  //       color: Colors.blue,
                                                                                                  //       child: const Center(
                                                                                                  //         child: Text(
                                                                                                  //           "Video Loading Error",
                                                                                                  //           textAlign: TextAlign.center,
                                                                                                  //           style: TextStyle(
                                                                                                  //             fontSize: 13,
                                                                                                  //           ),
                                                                                                  //         ),
                                                                                                  //       ),
                                                                                                  //     );
                                                                                                  //   },
                                                                                                  // ),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                h(5),
                                                                                singleReview.video.isEmpty
                                                                                    ? const SizedBox()
                                                                                    : SizedBox(
                                                                                        width: Get.width * 0.7,
                                                                                        height: Get.height * 0.1,
                                                                                        // color: AppColors.greyColor,
                                                                                        child: ListView.separated(
                                                                                          shrinkWrap: true,
                                                                                          scrollDirection: Axis.horizontal,
                                                                                          padding: const EdgeInsets.symmetric(),
                                                                                          itemCount: singleReview.video.length,
                                                                                          separatorBuilder: (context, index) {
                                                                                            return const SizedBox(width: 8);
                                                                                          },
                                                                                          itemBuilder: (context, index) {
                                                                                            var singleVideo = singleReview.video[index];

                                                                                            return GestureDetector(
                                                                                              onTap: () {
                                                                                                Get.toNamed(
                                                                                                  Routes.REVIEW_VIDEOS,
                                                                                                  arguments: [
                                                                                                    singleVideo.video,
                                                                                                    true,
                                                                                                  ],
                                                                                                );
                                                                                              },
                                                                                              child: Stack(
                                                                                                alignment: Alignment.center,
                                                                                                children: [
                                                                                                  SizedBox(
                                                                                                    width: 130.0,
                                                                                                    height: 84.0,
                                                                                                    child: ClipRRect(
                                                                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                                      child: CachedNetworkImage(
                                                                                                        imageUrl: singleVideo.thumbnail,
                                                                                                        fit: BoxFit.cover,
                                                                                                        errorWidget: (context, url, error) {
                                                                                                          return Container(
                                                                                                            color: AppColors.greyColor.withOpacity(0.45),
                                                                                                            child: const Center(
                                                                                                              child: Text(
                                                                                                                "Video Image\nNot Loaded",
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: TextStyle(
                                                                                                                  color: AppColors.blackColor,
                                                                                                                  fontSize: 12,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Image.asset(
                                                                                                    "assets/images/play.png",
                                                                                                    height: 16,
                                                                                                    width: 16,
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                h(10),
                                                                                index == 0
                                                                                    ? controller.viewMoreReviews.value
                                                                                        ? const SizedBox()
                                                                                        : ButtonWithStyle(
                                                                                            onPressed: () {
                                                                                              controller.viewMoreReviews.value = !controller.viewMoreReviews.value;
                                                                                              controller.update();
                                                                                            },
                                                                                            textVal: "VIEW MORE",
                                                                                            style: const TextStyle(
                                                                                              fontSize: 11,
                                                                                              color: Colors.white,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                            btnwidth: Get.width * 0.2,
                                                                                          )
                                                                                    : const SizedBox(),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "Nearby Places",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: Get.height *
                                                              0.02),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.28,
                                                        child: controller
                                                                .nearByPlacesList
                                                                .isEmpty
                                                            ? const Center(
                                                                child: Text(
                                                                    "No Nearby Places"),
                                                              )
                                                            : ListView.builder(
                                                                physics:
                                                                    const PageScrollPhysics(),
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemCount:
                                                                    controller
                                                                        .nearByPlacesList
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  var singleNearBy =
                                                                      controller
                                                                              .nearByPlacesList[
                                                                          index];
                                                                  return Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Stack(
                                                                            children: [
                                                                              Container(
                                                                                height: Get.height * 0.15,
                                                                                width: Get.width * 0.5,
                                                                                decoration: BoxDecoration(
                                                                                  color: AppColors.greyColor.withOpacity(0.25),
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                  // image:
                                                                                  //     DecorationImage(image: AssetImage("assets/images/view.png"),
                                                                                  //fit: BoxFit.fill),
                                                                                ),
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: singleNearBy.placeImage,
                                                                                  errorWidget: (context, url, error) {
                                                                                    return const Center(
                                                                                      child: Text("Image Not Loaded"),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                top: 0,
                                                                                left: 10,
                                                                                child: SizedBox(
                                                                                  height: Get.height * 0.06,
                                                                                  width: Get.width * 0.06,
                                                                                  child: Image.asset("assets/images/dil.png"),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          w(20),
                                                                        ],
                                                                      ),
                                                                      h(5),
                                                                      Text(
                                                                        singleNearBy
                                                                            .placesName,
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
                                                                            child:
                                                                                const Image(
                                                                              image: AssetImage("assets/images/star.png"),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: Get.width * 0.02),
                                                                          Text(
                                                                            singleNearBy.rating,
                                                                            // "4.0",
                                                                            style:
                                                                                const TextStyle(fontSize: 16),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Get.width * 0.02,
                                                                          ),
                                                                          Text(
                                                                            "${singleNearBy.totalReview} Reviews",
                                                                            style:
                                                                                const TextStyle(fontSize: 12, color: Colors.grey),
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
                                                                                Get.height * 0.02,
                                                                            child:
                                                                                const Image(
                                                                              image: AssetImage("assets/images/log.png"),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Get.width * 0.02,
                                                                          ),
                                                                          SizedBox(
                                                                              width: Get.width * 0.35,
                                                                              child: Text(
                                                                                singleNearBy.address,
                                                                                // "100 Laurier Street, Gatineau..",
                                                                                style: const TextStyle(
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: 12,
                                                                                  color: Colors.grey,
                                                                                ),
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
                                                                            child:
                                                                                const Image(
                                                                              image: AssetImage("assets/images/walking.png"),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: Get.width * 0.02),
                                                                          Text(
                                                                            singleNearBy.duration,
                                                                            // "2 min",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: Get.width * 0.02),
                                                                          Text(
                                                                            "${singleNearBy.distance} away",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            controller.reviewAllData == null
                                                ? const Center(
                                                    child: Text(
                                                        "No Review Images"),
                                                  )
                                                : controller.reviewAllData!
                                                        .reviewFile.isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                            "No Review Images"),
                                                      )
                                                    : GridView.builder(
                                                        itemCount: controller
                                                            .reviewAllData!
                                                            .reviewFile
                                                            .length,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10,
                                                        ),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          childAspectRatio: 1,
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 10,
                                                        ),
                                                        itemBuilder:
                                                            (context, index) {
                                                          var singleImage =
                                                              controller
                                                                  .reviewAllData!
                                                                  .reviewFile[index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                Routes
                                                                    .REVIEW_IMAGES,
                                                                arguments: [
                                                                  singleImage
                                                                      .file,
                                                                  true,
                                                                ],
                                                              );
                                                            },
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  singleImage
                                                                      .file,
                                                              errorWidget:
                                                                  (context, url,
                                                                      error) {
                                                                return Container(
                                                                  color: AppColors
                                                                      .greyColor
                                                                      .withOpacity(
                                                                          0.25),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "Image\nNot Loaded",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .blackColor,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                            controller.reviewAllData == null
                                                ? const Center(
                                                    child: Text(
                                                        "No Review Videos"),
                                                  )
                                                : controller.reviewAllData!
                                                        .reviewVideo.isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                            "No Review Videos"),
                                                      )
                                                    : GridView.builder(
                                                        itemCount: controller
                                                            .reviewAllData!
                                                            .reviewVideo
                                                            .length,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10,
                                                        ),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          childAspectRatio: 1,
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 10,
                                                          // mainAxisExtent: 120,
                                                        ),
                                                        itemBuilder:
                                                            (context, index) {
                                                          var singleVideo =
                                                              controller
                                                                  .reviewAllData!
                                                                  .reviewVideo[index];
                                                          //                                                 final createdThumbnailPath =  VideoThumbnail.thumbnailData(
                                                          // video: singleVideo.file,
                                                          // imageFormat: ImageFormat.JPEG,
                                                          // timeMs: 1,
                                                          // quality: 50);

                                                          // return CachedNetworkImage(
                                                          //   imageUrl:
                                                          //       singleVideo
                                                          //           .video,
                                                          // );
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                Routes
                                                                    .REVIEW_VIDEOS,
                                                                arguments: [
                                                                  singleVideo
                                                                      .video,
                                                                  true,
                                                                ],
                                                              );
                                                            },
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                AspectRatio(
                                                                  aspectRatio:
                                                                      1,
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        singleVideo
                                                                            .thumbnail,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorWidget:
                                                                        (context,
                                                                            url,
                                                                            error) {
                                                                      return Container(
                                                                        color: AppColors
                                                                            .greyColor
                                                                            .withOpacity(0.45),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            "Video Image\nNot Loaded",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppColors.blackColor,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  "assets/images/play.png",
                                                                  height: 16,
                                                                  width: 16,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                            // ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
