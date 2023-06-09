import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/add_profile_picture_controller.dart';

class AddProfilePictureView extends GetView<AddProfilePictureController> {
  const AddProfilePictureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Obx(() => controller.isLoading.value
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
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: Get.width * 0.4,
                                  child:
                                      Image.asset("assets/images/appIcon.png")),
                              h(20),
                              Text("Choose Profile Picture",
                                  style: AppTextStyle.size18Medium.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              h(20),
                              h(10),
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
                              h(20),
                              // Text(LocaleKeys.labels_The_Classics.tr,style: AppTextStyle.size18Medium.copyWith(fontSize: 16,fontWeight: FontWeight.w600)),
                              // Container(
                              //   height: Get.height * 0.4,
                              //   child: ListView.builder(
                              //     itemCount: controller.data.length,
                              //     itemBuilder: (context, index) {
                              //       return Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text("${controller.data[index].title}",
                              //               style: AppTextStyle.size18Medium
                              //                   .copyWith(
                              //                       fontSize: 16,
                              //                       fontWeight:
                              //                           FontWeight.w600)),
                              //           Container(
                              //             child: GridView.builder(
                              //               shrinkWrap: true,
                              //               itemCount: controller.images.length,
                              //               gridDelegate:
                              //                   SliverGridDelegateWithFixedCrossAxisCount(
                              //                       crossAxisCount: 3,
                              //                       crossAxisSpacing: 12,
                              //                       mainAxisSpacing: 10),
                              //               itemBuilder: (context, index) {
                              //                 return GestureDetector(
                              //                   onTap: ()  async {
                              //                           controller.storeimgselected = controller.images[index].images.toString();
                              //                           print("${controller.storeimgselected} ");
                              //                           controller.isPicked.value = true;
                              //                           controller.ispic.value = false;
                              //                           // controller.imageFile = File(controller.storeimgselected.toString());
                              //                   },
                              //                   child: Container(
                              //                     decoration: BoxDecoration(
                              //                         color: Colors.cyan,
                              //                         borderRadius:
                              //                             const BorderRadius.all(
                              //                                 Radius.circular(
                              //                                     5)),
                              //                         image: DecorationImage(
                              //                             image: NetworkImage(
                              //                                 controller
                              //                                     .images[index]
                              //                                     .images
                              //                                     .toString()),
                              //                             fit: BoxFit.fill)),
                              //                   ),
                              //                 );
                              //               },
                              //             ),
                              //           ),
                              //           h(10)
                              //         ],
                              //       );
                              //     },
                              //   ),
                              // ),
                              h(10),
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
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: Get.width * 0.4,
                                child:
                                    Image.asset("assets/images/appIcon.png")),
                            h(20),
                            Text(LocaleKeys.text_Add_Profile_Picture.tr,
                                style: AppTextStyle.size18Medium.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            h(20),
                            h(10),
                            Stack(
                              children: [
                                GetBuilder<AddProfilePictureController>(
                                    builder: (controller) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.ispic.value = true;
                                      controller.imageFile = null;
                                      controller.storeimgselected = "";
                                      print("hjh");
                                    },
                                    child: Container(
                                        height: Get.height * 0.08,
                                        width: Get.width * 0.2,
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                            image: controller.imageFile != null
                                                ? DecorationImage(
                                                    image: FileImage(
                                                        controller.imageFile!),
                                                    fit: BoxFit.fill,
                                                  )
                                                : controller.storeimgselected !=
                                                        null
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                            controller
                                                                .storeimgselected
                                                                .toString()),
                                                        fit: BoxFit.fill)
                                                    : const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/noman.png")),
                                          ),
                                        )),
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
                                      child:
                                          Image.asset("assets/images/add.png"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            h(10),
                            Text("${LocaleKeys.labels_Profile.tr} Name",
                                style: AppTextStyle.size14Medium.copyWith(
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w600)),
                            h(10),
                            InputTextField(
                              context: context,
                              controller: controller.otpController,
                              hintText: "Add Profile Name",
                            ),
                            h(50),
                            ButtonWithStyle(
                              onPressed: () {
                                controller.Addprofile();
                              },
                              textVal: LocaleKeys.buttons_save.tr.toUpperCase(),
                              btnwidth: Get.width,
                            ),
                            h(10),
                          ],
                        ),
                      ),
                    ),
            )),
    );
  }
}
