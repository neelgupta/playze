import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/app_colors.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../routes/app_pages.dart';
import '../controllers/writeareview_controller.dart';

class WriteareviewView extends GetView<WriteareviewController> {
  const WriteareviewView({Key? key}) : super(key: key);
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
                        padding: const EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(2),
                              child: const Image(
                                image: AssetImage("assets/images/back.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.text_Write_Review.tr,
                            style: const TextStyle(
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
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: Get.height * 0.72,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();

                    return true;
                  },
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.reviewFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.text_Give_your_rating.tr,
                            style: const TextStyle(fontSize: 18),
                          ),
                          h(10),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            height: Get.height * 0.12,
                            width: Get.width,
                            child: Center(
                              child: RatingBar.builder(
                                itemSize: 40,
                                initialRating: controller.ratingValue.value,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                glow: false,
                                onRatingUpdate: (rating) {
                                  // print(rating);
                                  controller.ratingValue.value = rating;
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                          h(10),
                          Text(
                            LocaleKeys.text_Write_Review.tr,
                            style: const TextStyle(fontSize: 18),
                          ),
                          h(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            height: Get.height * 0.2,
                            width: Get.width,
                            child: TextFormField(
                              controller: controller.reviewController,
                              maxLines: 6,
                              validator: (value) {
                                if (value!.isEmpty || value == " ") {
                                  return "Please Enter Review Data";
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: LocaleKeys.text_Add_here.tr,
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.text_Upload_Videos.tr,
                                style: const TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.showPickerBottomSheet();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  height: Get.height * 0.09,
                                  width: Get.width * 0.1,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber,
                                  ),
                                  child: Image.asset("assets/images/add.png"),
                                ),
                              )
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     GestureDetector(onTap: () {
                          //       // controller.selectFile();
                          //     }, child:
                          //         GetBuilder<WriteareviewController>(builder: (controller) {
                          //       return Stack(
                          //         children: [
                          //           Container(
                          //             child: controller.isPicked.value
                          //                 ? Image.file(
                          //                     controller.imageFile!,
                          //                     width: Get.width * 0.4,
                          //                     height: Get.height * 0.11,
                          //                   )
                          //                 : Container(
                          //                     decoration: BoxDecoration(
                          //                       image: const DecorationImage(
                          //                           image: AssetImage(
                          //                               "assets/images/femily.png"),
                          //                           fit: BoxFit.fill),
                          //                       color: Colors.blueGrey[100],
                          //                       borderRadius: const BorderRadius.all(
                          //                         Radius.circular(10),
                          //                       ),
                          //                     ),
                          //                     width: Get.width * 0.4,
                          //                     height: Get.height * 0.11,
                          //                   ),
                          //           ),
                          //           Positioned(
                          //             top: 0,
                          //             right: 4,
                          //             child: GestureDetector(
                          //               onTap: () {
                          //                 controller.Close();
                          //                 controller.update();
                          //               },
                          //               child: Container(
                          //                 decoration: const BoxDecoration(
                          //                     borderRadius:
                          //                         BorderRadius.all(Radius.circular(10))),
                          //                 height: Get.height * 0.04,
                          //                 width: Get.width * 0.05,
                          //                 child: Image.asset(
                          //                   "assets/images/close.png",
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       );
                          //     })),
                          //     w(10),
                          //     Obx(
                          //       () => Stack(
                          //         children: [
                          //           Container(
                          //             decoration: const BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.all(Radius.circular(10))),
                          //             child: controller.isPickeds.value
                          //                 ? Image.file(
                          //                     controller.imagevideoFile!,
                          //                     width: Get.width * 0.4,
                          //                     height: Get.height * 0.11,
                          //                   )
                          //                 : Container(
                          //                     decoration: BoxDecoration(
                          //                         image: const DecorationImage(
                          //                           image: AssetImage(
                          //                               "assets/images/femily.png"),
                          //                           fit: BoxFit.fill,
                          //                         ),
                          //                         color: Colors.blueGrey[100],
                          //                         borderRadius: const BorderRadius.all(
                          //                             Radius.circular(10))),
                          //                     width: Get.width * 0.4,
                          //                     height: Get.height * 0.11,
                          //                   ),
                          //           ),
                          //           Positioned(
                          //             top: 0,
                          //             right: 4,
                          //             child: GestureDetector(
                          //               onTap: () {},
                          //               child: SizedBox(
                          //                 height: Get.height * 0.04,
                          //                 width: Get.width * 0.05,
                          //                 child: Image.asset("assets/images/close.png"),
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Images"),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: Get.size.height * 0.16,
                                child: controller.imageFiles.isEmpty
                                    ? const Center(
                                        child: Text("No Videos Picked"),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(width: 10);
                                        },
                                        itemCount: controller.imageFiles.isEmpty
                                            ? 2
                                            : controller.imageFiles.length,
                                        itemBuilder: (context, index) {
                                          // var item = controller.videoFiles[index].thumbnailPath;
                                          return Stack(
                                            children: [
                                              Container(
                                                height: 96,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                child: Container(
                                                  height: 96,
                                                  width: 162,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: controller
                                                          .isImagePicked.value
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(
                                                              Routes
                                                                  .REVIEW_IMAGES,
                                                              arguments: [
                                                                controller
                                                                    .imageFiles[
                                                                        index]
                                                                    .filePath,
                                                                false,
                                                              ],
                                                            );
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  8),
                                                            ),
                                                            child: Image.file(
                                                              File(controller
                                                                  .imageFiles[
                                                                      index]
                                                                  .filePath),
                                                              fit: BoxFit.cover,
                                                              // width: Get.width * 0.4,
                                                              // height: Get.height * 0.11,
                                                            ),
                                                          ),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(8),
                                                          ),
                                                          child: Image.asset(
                                                            "assets/images/femily.png",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 4,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .removeImageFromList(
                                                            index);
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    height: Get.height * 0.04,
                                                    width: Get.width * 0.05,
                                                    child: Image.asset(
                                                      "assets/images/close.png",
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Videos"),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 100,
                                child: controller.videoFiles.isEmpty
                                    ? const Center(
                                        child: Text("No Videos Picked"),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(width: 10);
                                        },
                                        itemCount: controller.videoFiles.isEmpty
                                            ? 2
                                            : controller.videoFiles.length,
                                        itemBuilder: (context, index) {
                                          // var item = controller.videoFiles[index].thumbnailPath;
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                height: 96,
                                                width: 162,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                child: controller
                                                        .isVideoPicked.value
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                            Routes
                                                                .REVIEW_VIDEOS,
                                                            arguments: [
                                                              controller
                                                                  .videoFiles[
                                                                      index]
                                                                  .filePath,
                                                              false,
                                                            ],
                                                          );
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(8),
                                                          ),
                                                          child: Image.file(
                                                            File(controller
                                                                .videoFiles[
                                                                    index]
                                                                .thumbnailPath),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(8),
                                                        ),
                                                        child: Image.asset(
                                                          "assets/images/femily.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 4,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .removeVideoFromList(
                                                            index);
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    height: Get.height * 0.04,
                                                    width: Get.width * 0.05,
                                                    child: Image.asset(
                                                      "assets/images/close.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.REVIEW_VIDEOS,
                                                      arguments: [
                                                        controller
                                                            .videoFiles[index]
                                                            .filePath,
                                                        false,
                                                      ],
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/play.png",
                                                    height: 16,
                                                    width: 16,
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                          h(15),
                          ButtonWithStyle(
                            onPressed: () {
                              if (controller.reviewFormKey.currentState!
                                  .validate()) {
                                if (controller.ratingValue.value == 0.0) {
                                  Fluttertoast.showToast(
                                    msg: 'Please Give your rating stars.',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                } else {
                                  controller.addReviewApi();
                                }
                              }
                              // Get.toNamed(Routes.CHILDINFO);
                            },
                            textVal: LocaleKeys.buttons_next.tr.toUpperCase(),
                            btnwidth: Get.width,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const btmbar(
        fromOther: true,
      ),
      extendBody: true,
    );
  }
}
