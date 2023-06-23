import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/reusability/utils/app_colors.dart';

import '../../../../reusability/utils/util.dart';
import '../../../data/modal/work_space_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/playze_workspace_controller.dart';

// ignore: must_be_immutable
class SingleWorkSpaceWidget extends StatelessWidget {
  SingleWorkSpaceWidget({
    Key? key,
    required this.workSpaceData,
  }) : super(key: key);

  final WorkSpaceData workSpaceData;
  var controller = Get.find<PlayzeWorkSpaceController>();

  @override
  Widget build(BuildContext context) {
    log("workSpaceData.isfavorite : ${workSpaceData.isfavorite}");
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          // height: Get.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyColor.withOpacity(0.25),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
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
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: workSpaceData.image,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) {
                              return const Center(
                                child: Text(
                                  "Image Not Loaded",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.blackColor,
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
                        child: GestureDetector(
                          onTap: () async {
                            if (workSpaceData.isfavorite) {
                              controller.removeFromWishListFunction(
                                placeId: workSpaceData.id,
                              );
                            } else {
                              await controller.addTowishListFunction(
                                placeId: workSpaceData.id,
                              );
                            }
                          },
                          child: workSpaceData.isfavorite
                              ? Image.asset(
                                  "assets/images/dil2.png",
                                  color: AppColors.redColor,
                                  height: 24,
                                  width: 24,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    "assets/images/dil.png",
                                    color: AppColors.whiteColor,
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workSpaceData.placesName,

                          // "Children’s Museum",
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: Get.height * 0.02,
                              child: const Image(
                                image: AssetImage("assets/images/star.png"),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Text(
                              workSpaceData.rating.toString(),
                              // "4.0",
                              style: const TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Text(
                              "${workSpaceData.totalRating} Reviews",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
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
                                  workSpaceData.address,
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
                          height: Get.height * 0.01,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: Get.height * 0.02,
                              child: const Image(
                                image: AssetImage("assets/images/walking.png"),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            const Text(
                              "2 min",
                              // data not coming from api
                              // workSpaceData.duration
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            const Text(
                              "1 km away",
                              // data not coming from api
                              // workSpaceData.distance
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.gotoMapPlaceLocation(
                        placeId: workSpaceData.id,
                      );
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
                  SizedBox(width: Get.width * 0.025),
                  GestureDetector(
                    onTap: () {
                      controller.addPlanToSelectedDay(
                        placeId: workSpaceData.id,
                      );
                    },
                    child: const Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/plan.png"),
                          width: 25,
                        ),
                        Text("  My Plan"),
                      ],
                    ),
                  ),
                  ButtonWithStyle(
                    onPressed: () {
                      // Get.toNamed(Routes.FULL_DETAILS);
                      Get.toNamed(
                        Routes.FULL_DETAILS,
                        arguments: [
                          workSpaceData.id,
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
        Positioned(
          top: 10,
          right: 5,
          child: GestureDetector(
            onTap: () async {
              await controller.removeWorkSpaceFunction(
                  placeId: workSpaceData.id);
            },
            child: const Icon(Icons.close),
          ),
        )
      ],
    );
  }
}
