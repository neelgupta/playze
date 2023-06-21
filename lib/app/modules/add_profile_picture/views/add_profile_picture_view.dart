import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/reusability/shared/common_text_field.dart';
import 'package:playze/reusability/shared/app_text_style.dart';
import 'package:playze/reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../../reusability/utils/app_colors.dart';
import '../controllers/add_profile_picture_controller.dart';

class AddProfilePictureView extends GetView<AddProfilePictureController> {
  const AddProfilePictureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Obx(
                () => controller.ispic.value
                    ? Container(
                        height: Get.height,
                        width: Get.width,
                        alignment: Alignment.center,
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          margin: const EdgeInsets.only(top: 0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                h(Get.height * 0.1),
                                SizedBox(
                                  width: Get.width * 0.4,
                                  child:
                                      Image.asset("assets/images/appIcon.png"),
                                ),
                                h(20),
                                Text(
                                  "Choose Profile Picture",
                                  style: AppTextStyle.size18Medium.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                h(30),

                                GetBuilder<AddProfilePictureController>(
                                    builder: (controller) {
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.getFromCamera();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          height: Get.height * 0.06,
                                          width: Get.width * 0.15,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                              "assets/images/photocamera.png"),
                                        ),
                                      ),
                                      w(10),
                                      GestureDetector(
                                        onTap: () {
                                          controller.getFromGallery();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          alignment: Alignment.center,
                                          height: Get.height * 0.06,
                                          width: Get.width * 0.15,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                              "assets/images/galri.png"),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                // h(20),
                                // Text(LocaleKeys.labels_The_Classics.tr,style: AppTextStyle.size18Medium.copyWith(fontSize: 16,fontWeight: FontWeight.w600)),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.activeEmojiDataList.length,
                                  itemBuilder: (context, index) {
                                    var singleData =
                                        controller.activeEmojiDataList[index];
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          singleData.title,
                                          style: AppTextStyle.size18Medium
                                              .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        h(10),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: singleData.emojis.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, ind) {
                                            return GestureDetector(
                                              onTap: () async {
                                                controller.isEmojiSelected
                                                    .value = true;
                                                controller.selectedEmoji =
                                                    singleData.emojis[ind];
                                                // controller.storeimgselected =
                                                //     singleData
                                                //         .emojis[ind].images
                                                //         .toString();
                                                log("controller.selectedEmoji!.images :: ${controller.selectedEmoji!.images}");
                                                controller.isPicked.value =
                                                    true;
                                                controller.ispic.value = false;
                                                // controller.imageFile = File(controller.storeimgselected.toString());
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    // image: DecorationImage(
                                                    //   image: NetworkImage(
                                                    //       singleData
                                                    //           .emojis[ind].images
                                                    //           .toString()),
                                                    //   fit: BoxFit.cover,
                                                    // ),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: singleData
                                                        .emojis[ind].images
                                                        .toString(),
                                                    fit: BoxFit.contain,
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
                                            );
                                          },
                                        ),
                                        h(10)
                                      ],
                                    );
                                  },
                                ),
                                h(60),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: Get.height,
                        width: Get.width,
                        alignment: Alignment.center,
                        color: Colors.blue,
                        padding:
                            const EdgeInsets.only(left: 18, right: 18, top: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width * 0.4,
                                child: Image.asset("assets/images/appIcon.png"),
                              ),
                              h(30),
                              Text(
                                LocaleKeys.text_Add_Profile_Picture.tr,
                                style: AppTextStyle.size18Medium.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              h(30),
                              Stack(
                                children: [
                                  GetBuilder<AddProfilePictureController>(
                                      builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.ispic.value = true;
                                        controller.imageFile = null;
                                        controller.selectedEmoji = null;
                                        log("hjh");
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                          child: controller.imageFile != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(200),
                                                  ),
                                                  child: Image.file(
                                                    controller.imageFile!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : controller.selectedEmoji != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(200),
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .selectedEmoji!
                                                            .images
                                                            .toString(),
                                                        fit: BoxFit.contain,
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
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  : Image.asset(
                                                      "assets/images/noman.png"),
                                        ),
                                      ),
                                    );
                                  }),
                                  Positioned(
                                    bottom: 5,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        height: Get.height * 0.03,
                                        width: Get.width * 0.06,
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                            "assets/images/add.png"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              h(25),
                              Text(
                                "${LocaleKeys.labels_Profile.tr} Name",
                                style: AppTextStyle.size16Medium.copyWith(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              h(10),
                              InputTextField(
                                context: context,
                                controller: controller.profileNameController,
                                hintText: "Add Profile Name",
                                // validator: (val) {
                                //   if (val!.isEmpty || val == " ") {
                                //     return "Please enter profile name";
                                //   }
                                //   return null;
                                // },
                              ),
                              h(10),
                              Obx(
                                () => controller.isError.value
                                    ? SizedBox(
                                        child: Text(
                                          controller.errorString.value,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      )
                                    : Container(),
                              ),
                              h(50),
                              ButtonWithStyle(
                                onPressed: () {
                                  log("controller.imageFile ;; ${controller.imageFile}");
                                  // log("controller.storeimgselected ;; ${controller.selectedEmoji!.images}");
                                  if (controller
                                          .profileNameController.text.isEmpty ||
                                      controller.profileNameController.text ==
                                          " ") {
                                    controller.isError.value = true;

                                    controller.errorString.value =
                                        "Please Enter Profile Name";
                                  } else if (controller.imageFile == null &&
                                      controller.selectedEmoji == null) {
                                    controller.isError.value = true;

                                    controller.errorString.value =
                                        "Please Choose Profile Image Or Emoji";
                                  }
                                  //  else if (controller.isEmojiSelected.value) {
                                  //   if (controller.storeimgselected == null) {
                                  //     controller.isError.value = true;

                                  //     controller.errorString.value =
                                  //         "Please Choose Profile Image";
                                  //   }
                                  // }
                                  else {
                                    controller.isError.value = false;
                                    controller.addProfileData();
                                  }
                                },
                                textVal: LocaleKeys.buttons_save.tr,
                                btnwidth: Get.width,
                              ),
                              h(10),
                            ],
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
