import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Reusability/utils/util.dart';
import '../../../data/modal/workmodal.dart';
import '../../../routes/app_pages.dart';

class SingleWorkSpaceWidget extends StatelessWidget {
  const SingleWorkSpaceWidget({
    Key? key,
    required this.workSpaceData,
  }) : super(key: key);

  final WorkSData workSpaceData;
  // var controller = Get.find<PlayzeWorkspaceController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            height: Get.height * 0.25,
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
                                      image: AssetImage(
                                          "assets/images/star.png"))),
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
                                    fontSize: 12, color: Colors.grey),
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
                                      image:
                                          AssetImage("assets/images/log.png"))),
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
                                        color: Colors.grey),
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
                                      image: AssetImage(
                                          "assets/images/walking.png"))),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              const Text(
                                "2 min",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              const Text(
                                "1 km away",
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
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Image(
                          image: AssetImage("assets/images/go.png"),
                          width: 25,
                        ),
                        const Text("  Go"),
                      ],
                    ),
                    SizedBox(
                      width: Get.width * 0.025,
                    ),
                    Row(
                      children: [
                        const Image(
                          image: AssetImage("assets/images/plan.png"),
                          width: 25,
                        ),
                        const Text("  My Plan"),
                      ],
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
        ),
        // Positioned(
        //   top: 10,
        //   right: 10,
        //   child: GestureDetector(
        //     onTap: () {},
        //     child: Icon(Icons.close),
        //   ),
        // )
      ],
    );
  }
}
