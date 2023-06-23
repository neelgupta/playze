import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/reusability/shared/custom_bottom_bar.dart';

import '../controllers/review_images_controller.dart';

class ReviewImagesView extends GetView<ReviewImagesController> {
  const ReviewImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1,
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
                        padding: const EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              child: const Image(
                                image: AssetImage("assets/images/back.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Review Images",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "spartan",
                            fontWeight: FontWeight.bold,
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
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: controller.isNetwork
            ? CachedNetworkImage(
                imageUrl: controller.imageUrl,
                errorWidget: (context, url, error) {
                  return const Center(
                    child: Text("No Image Found"),
                  );
                },
              )
            : Image.asset(controller.imageUrl),
      ),
      bottomNavigationBar: const CustomBottomBar(fromOther: true),
      extendBody: true,
    );
  }
}
