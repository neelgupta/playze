// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/app_colors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../../Reusability/utils/util.dart';
import '../../../routes/app_pages.dart';
import '../controllers/full_details_controller.dart';

class FullDetailsView extends GetView<FullDetailsController> {
  const FullDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const btmbar(fromOther: true),
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
                            log("favourite butto tapped");
                          },
                        ),
                      ),
                    ],
                    backgroundColor: AppColors.primaryColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Swiper(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.wSData!.data.images.isNotEmpty
                            ? controller.wSData?.data.images.length
                            : 1,
                        layout: SwiperLayout.DEFAULT,
                        // viewportFraction: 1.2,
                        pagination: const SwiperPagination(
                          margin: EdgeInsets.only(bottom: 15),
                        ),
                        autoplayDelay: 2500,
                        containerHeight: Get.height * 0.34,

                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          var imageUrl =
                              controller.wSData!.data.images[index].images;

                          // log("imageUrl :: $imageUrl");
                          return SizedBox(
                            height: Get.height * 0.33,
                            // height: Get.height * 0.25,
                            width: Get.width,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
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
                            ),

                            // Image.network(
                            //     "${controller.wSData?.data.images[index].images.toString()}",
                            //     fit: BoxFit.fill),
                          );
                        },
                      ),
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
                                          Row(
                                            children: const [
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
                                          Row(
                                            children: const [
                                              Image(
                                                image: AssetImage(
                                                    "assets/images/plus.png"),
                                                width: 25,
                                              ),
                                              Text("  Playze Workspace"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.03),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${controller.wSData?.data.placesName}",
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
                                      //        print(object)
                                      //     },
                                      //   ),
                                      // ),
                                      Row(
                                        children: [
                                          SmoothStarRating(
                                            allowHalfRating: true,
                                            color: Colors.amber,
                                            borderColor: Colors.amber,
                                            rating: int.parse(controller
                                                    .wSData!.data.avgRating)
                                                .toDouble(),
                                            size: 20,
                                            starCount: 5,
                                            isReadOnly: true,
                                            defaultIconData:
                                                Icons.star_outline_rounded,
                                            filledIconData: Icons.star_rounded,
                                            halfFilledIconData:
                                                Icons.star_half_rounded,
                                          ),
                                          w(10),
                                          Text(
                                            "${int.parse(controller.wSData!.data.avgRating).toDouble()}",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${controller.wSData?.data.description}",
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
                                                itemCount: controller.wSData!
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
                                                      Text(
                                                        "${controller.wSData?.data.highlights[index].highlights}",
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
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
                                            print(controller.tabon.value);
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
                                              .wSData!.data.images.length,
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
                                                            .wSData
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
                                                            "${controller.wSData?.data.images[index].images}",
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
                                                    "${controller.wSData?.data.images[index].imagesTitle}",
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
                                              .wSData!.data.video.length,
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
                                                      Routes.REVIEW_VIDEOS,arguments: [
                                                        controller.wSData?.data.video[index].videoImage,],
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
                                                                "${controller.wSData?.data.video[index].videoImage}",
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
                                                    "${controller.wSData?.data.video[index].videoTitle}",
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
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: const [
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
                                                      Text(
                                                        "For Adults      :",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      w(10),
                                                      Text(
                                                        "\$ ${controller.wSData?.data.costAdults}",
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
                                                      Text(
                                                        "For Children   :",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      w(10),
                                                      Text(
                                                        "\$ ${controller.wSData?.data.costChildren}",
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
                                              //       "\$ ${controller.wSData?.data.costAdults}",
                                              //       style: const TextStyle(
                                              //           fontSize: 18,
                                              //           color:
                                              //               Colors.blueAccent),
                                              //     ),
                                              //     Text(
                                              //       "\$ ${controller.wSData?.data.costChildren}",
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
                                                "${controller.wSData?.data.contactNo}",
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
                                                    "${controller.wSData?.data.address}",
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
                                                "${controller.wSData?.data.time}",
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
                                              fit: BoxFit.fill)),
                                      child: const GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(37.43296265331129,
                                                -122.08832357078792),
                                            tilt: 10,
                                            zoom: 14.5),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 20,
                                      child: SizedBox(
                                        height: Get.height * 0.07,
                                        width: Get.width * 0.08,
                                        child: Image.asset(
                                            "assets/images/blueback.png"),
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
                                            "assets/images/Block.png"),
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
                                              // Get.toNamed(Routes.WRITEAREVIEW);
                                            },
                                            textVal: "Add Reviews",
                                            style: TextStyle(
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
                                                      "${controller.wSData?.data.totalRating}",
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
                                                          "${int.parse(controller.wSData!.data.avgRating).toDouble()}",
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
                                                              .wSData!
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
                                                              .wSData!
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
                                                              .wSData!
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
                                                              .wSData!
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
                                                              .wSData!
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
                                            0.8, //height of TabBarView
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
                                                    left: 20, right: 20),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.35,
                                                            width: Get.width *
                                                                0.13,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      Get.height *
                                                                          0.1,
                                                                  width:
                                                                      Get.width *
                                                                          0.15,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/images/profilepic.png"),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          w(20),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            // height: Get.height *
                                                            //     0.35,
                                                            width:
                                                                Get.width * 0.7,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: RatingBar
                                                                      .builder(
                                                                    itemSize:
                                                                        20,
                                                                    initialRating:
                                                                        3.5,
                                                                    minRating:
                                                                        1,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    itemPadding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            2.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                                _) =>
                                                                            const Icon(
                                                                      Icons
                                                                          .star,
                                                                      size: 16,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                    onRatingUpdate:
                                                                        (rating) {
                                                                      print(
                                                                          rating);
                                                                    },
                                                                  ),
                                                                ),
                                                                h(5),
                                                                const Text(
                                                                  "by Darryl McKinnon on April 22, 2020",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                h(5),
                                                                const Text(
                                                                  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum...",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                                h(5),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              10)),
                                                                          image: DecorationImage(
                                                                              image: AssetImage("assets/images/view.png"),
                                                                              fit: BoxFit.fill)),
                                                                      width: Get
                                                                              .width *
                                                                          0.32,
                                                                      height:
                                                                          Get.height *
                                                                              0.1,
                                                                    ),
                                                                    w(5),
                                                                    Container(
                                                                      decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              10)),
                                                                          image: DecorationImage(
                                                                              image: AssetImage("assets/images/view.png"),
                                                                              fit: BoxFit.fill)),
                                                                      width: Get
                                                                              .width *
                                                                          0.32,
                                                                      height:
                                                                          Get.height *
                                                                              0.1,
                                                                    ),
                                                                  ],
                                                                ),
                                                                h(5),
                                                                ButtonWithStyle(
                                                                  onPressed:
                                                                      () {},
                                                                  textVal:
                                                                      "VIEW MORE",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                  btnwidth:
                                                                      Get.width *
                                                                          0.2,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
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
                                                        height:
                                                            Get.height * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.28,
                                                        child: ListView.builder(
                                                          physics:
                                                              PageScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: 5,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Container(
                                                              child: Column(
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
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                              image: DecorationImage(image: AssetImage("assets/images/view.png"), fit: BoxFit.fill),
                                                                            ),
                                                                            height:
                                                                                Get.height * 0.15,
                                                                            width:
                                                                                Get.width * 0.5,
                                                                          ),
                                                                          Positioned(
                                                                            top:
                                                                                3,
                                                                            left:
                                                                                10,
                                                                            child:
                                                                                SizedBox(
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
                                                                  const Text(
                                                                      "Children’s Museum"),
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            0.01,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                          height: Get.height *
                                                                              0.02,
                                                                          child:
                                                                              const Image(image: AssetImage("assets/images/star.png"))),
                                                                      SizedBox(
                                                                        width: Get.width *
                                                                            0.02,
                                                                      ),
                                                                      const Text(
                                                                        "4.0",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                      SizedBox(
                                                                        width: Get.width *
                                                                            0.02,
                                                                      ),
                                                                      const Text(
                                                                        "150 Reviews",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            0.01,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                          height: Get.height *
                                                                              0.02,
                                                                          child:
                                                                              const Image(image: AssetImage("assets/images/log.png"))),
                                                                      SizedBox(
                                                                        width: Get.width *
                                                                            0.02,
                                                                      ),
                                                                      SizedBox(
                                                                          width: Get.width *
                                                                              0.35,
                                                                          child:
                                                                              const Text(
                                                                            "100 Laurier Street, Gatineau..",
                                                                            style: TextStyle(
                                                                                overflow: TextOverflow.ellipsis,
                                                                                fontSize: 12,
                                                                                color: Colors.grey),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            0.01,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                          height: Get.height *
                                                                              0.02,
                                                                          child:
                                                                              const Image(image: AssetImage("assets/images/walking.png"))),
                                                                      SizedBox(
                                                                        width: Get.width *
                                                                            0.02,
                                                                      ),
                                                                      const Text(
                                                                          "2 min",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey)),
                                                                      SizedBox(
                                                                        width: Get.width *
                                                                            0.02,
                                                                      ),
                                                                      const Text(
                                                                          "1 km away",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey)),
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
                                                )),
                                            const Center(
                                              child: Text('Display Tab 2',
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            const Center(
                                              child: Text('Display Tab 3',
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
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
