import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../Reusability/utils/util.dart';
import '../../../data/modal/plaseModel.dart';
import '../../../routes/app_pages.dart';
import '../../BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';
import '../controllers/home_controller.dart';

class SinglePlaceWidget extends StatelessWidget {
  SinglePlaceWidget({
    super.key,
    required this.placeData,
  });

  final PlaceDetails placeData;
  // final HomeController controller;
  // final BottomNavigationbarController controllerc;

  final controller = Get.find<HomeController>();
  final bottomCont = Get.find<BottomNavigationbarController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          // height: Get.height * 0.25,

          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: Get.height * 0.12,
                        width: Get.width * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
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
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: placeData.images!.first.images!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return const Center(
                                child: Text("No Image"),
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
                              image: AssetImage("assets/images/dil.png")),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${placeData.placesName}"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          placeData.avgRating != "0" ||
                                  placeData.totalReview != "0"
                              ? Row(
                                  children: [
                                    placeData.avgRating != "0"
                                        ? SizedBox(
                                            height: Get.height * 0.02,
                                            child: const Image(
                                                image: AssetImage(
                                                    "assets/images/star.png")))
                                        : h(1),
                                    placeData.avgRating != "0"
                                        ? SizedBox(
                                            width: Get.width * 0.02,
                                          )
                                        : h(1),
                                    placeData.avgRating != "0"
                                        ? Text(
                                            double.parse(placeData.avgRating
                                                    .toString())
                                                .toStringAsFixed(1),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        : h(1),
                                    SizedBox(width: Get.width * 0.02),
                                    placeData.totalReview != "0"
                                        ? Text(
                                            '${placeData.totalReview}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          )
                                        : h(1),
                                    placeData.totalReview != "0"
                                        ? const Text(
                                            ' Reviews',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          )
                                        : h(1),
                                  ],
                                )
                              : h(1),
                          SizedBox(height: Get.height * 0.01),
                          Row(
                            children: [
                              SizedBox(
                                height: Get.height * 0.02,
                                child: const Image(
                                  image: AssetImage("assets/images/log.png"),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              SizedBox(
                                width: Get.width * 0.35,
                                child: Text(
                                  "${placeData.address}",
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      color: Colors.grey),
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
                                  image:
                                      AssetImage("assets/images/walking.png"),
                                ),
                              ),
                              SizedBox(width: Get.width * 0.02),
                              Expanded(
                                child: Text(
                                  "${placeData.duration} ${placeData.distance} away",
                                  // "2 min",
                                  maxLines: 2,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              // SizedBox(width: Get.width * 0.02),
                              // Text(
                              //   "${placeData.distance} away",
                              //   style: const TextStyle(
                              //     fontSize: 12,
                              //     color: Colors.grey,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      controller.isMapView.value = true;
                      controller.selectedPlaceLocation = placeData;
                      controller.initialCameraPosition = CameraPosition(
                        target: LatLng(
                            double.parse(
                                controller.selectedPlaceLocation!.latitude!),
                            double.parse(
                                controller.selectedPlaceLocation!.longitude!)),
                        tilt: 10,
                        zoom: 14.5,
                      );

                      bottomCont.locateWindowPop.value = true;
                    },
                    child: const Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/go.png"),
                          width: 25,
                        ),
                        Text("  Go"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.025,
                  ),
                  const Row(
                    children: [
                      Image(
                        image: AssetImage("assets/images/plan.png"),
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
                          placeData.id,
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
        h(15)
      ],
    );
  }
}
