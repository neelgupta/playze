import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../../Reusability/utils/app_colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

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
                        padding: const EdgeInsets.all(5),
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
                      width: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Edit Profile",
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
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Container(
                height: Get.height,
                margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 75,
                            child: Stack(
                              children: [
                                GetBuilder<EditProfileController>(
                                    builder: (controller) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectFile();
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(200),
                                        ),
                                        child: controller.imageFile != null
                                            ? Image.file(
                                                controller.imageFile!,
                                                fit: BoxFit.fill,
                                              )
                                            : controller.profileData?.data
                                                        .images !=
                                                    ""
                                                ? CachedNetworkImage(
                                                    imageUrl: controller
                                                            .profileData
                                                            ?.data
                                                            .images ??
                                                        "",
                                                    fit: BoxFit.fill,
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return const Center(
                                                        child: Text(
                                                          "No Image",
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .blackColor,
                                                            fontSize: 9,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : const SizedBox(),
                                      ),

                                      //  Container(
                                      //   decoration: BoxDecoration(
                                      //     image: controller.imageFile != null
                                      //         ? DecorationImage(
                                      //             image: FileImage(
                                      //                 controller.imageFile!),
                                      //             fit: BoxFit.fill)
                                      //         : null,
                                      //     color: Colors.orange,
                                      //     shape: BoxShape.circle,
                                      //   ),
                                      // ),
                                    ),
                                  );
                                }),
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 22,
                                      width: 22,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          w(15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.profileData?.data.name}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              h(5),
                              Row(
                                children: [
                                  // Text(
                                  //   "25 Old |",
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                  Text(
                                    controller.profileData?.data.location ?? "",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      h(20),
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            (LocaleKeys.labels_name.tr),
                            style: const TextStyle(fontSize: 16),
                          )),
                      h(5),
                      Container(
                        width: Get.width,
                        height: Get.height * 0.065,
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.00)),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: controller.Name,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Kevin Zegers",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      // InputTextField(
                      //   borderColor: Colors.grey,
                      //   borderRadius: 10,
                      //   hintTextStyle: TextStyle(color: Colors.grey),
                      //   context: context,
                      //   controller: controller.Name,
                      //   hintText: "Kevin Zegers",
                      // ),
                      Obx(
                        () => controller.fnamestatus.value
                            ? SizedBox(
                                child: Text(
                                  controller.status,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )
                            : Container(),
                      ),
                      h(15),
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            (LocaleKeys.labels_email.tr),
                            style: const TextStyle(fontSize: 16),
                          )),
                      h(5),
                      InputTextField(
                        style: const TextStyle(color: Colors.black),
                        borderColor: Colors.grey,
                        borderRadius: 10,
                        cursorColor: Colors.black,
                        hintTextStyle: const TextStyle(color: Colors.grey),
                        context: context,
                        controller: controller.Email,
                        hintText: "Kevin@email.com",
                      ),
                      Obx(
                        () => controller.emailstatus.value
                            ? SizedBox(
                                child: Text(
                                  controller.status,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )
                            : Container(),
                      ),
                      h(15),
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            (LocaleKeys.labels_phone.tr),
                            style: const TextStyle(fontSize: 16),
                          )),
                      h(5),
                      InputTextField(
                        borderColor: Colors.grey,
                        borderRadius: 10,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        hintTextStyle: const TextStyle(color: Colors.grey),
                        context: context,
                        controller: controller.PhoneNumber,
                        hintText: "+1 985 547 2222",
                      ),
                      Obx(
                        () => controller.phonestatus.value
                            ? SizedBox(
                                child: Text(
                                  controller.status,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )
                            : Container(),
                      ),
                      h(15),
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            (LocaleKeys.labels_Your_Location.tr),
                            style: const TextStyle(fontSize: 16),
                          )),
                      h(5),
                      InputTextField(
                        borderColor: Colors.grey,
                        borderRadius: 10,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        hintTextStyle: const TextStyle(color: Colors.grey),
                        context: context,
                        controller: controller.YourLocation,
                        hintText: "Dieppe, Canada.",
                      ),
                      h(5),
                      Obx(
                        () => controller.yourLocationStatus.value
                            ? SizedBox(
                                child: Text(
                                  controller.status,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )
                            : Container(),
                      ),
                      h(25),
                      GetBuilder<EditProfileController>(builder: (_) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => h(20),
                          itemCount: controller.ageControllersList.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: index == 0
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    (LocaleKeys
                                                        .labels_Children_information
                                                        .tr),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                              h(15),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  ("${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_name.tr} ${index + 1}"),
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ),
                                              h(5),
                                              InputTextField(
                                                width: Get.width,
                                                borderColor: Colors.grey,
                                                borderRadius: 10,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                hintTextStyle: const TextStyle(
                                                    color: Colors.grey),
                                                context: context,
                                                cursorColor: Colors.black,
                                                controller: controller
                                                    .nameControllersList[index],
                                                hintText: "Zoe Saldana",
                                              ),
                                              h(15),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  child: Text(
                                                    ("${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_age.tr} ${index + 1}"),
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  )),
                                              h(5),
                                              Container(
                                                height: Get.height * 0.065,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Get.width * 0.03),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.00)),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: controller
                                                          .ageControllersList[
                                                      index],
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Age",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  child: Text(
                                                    ("${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_name.tr} ${index + 1}"),
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  )),
                                              h(5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InputTextField(
                                                    width: Get.width * 0.75,
                                                    borderColor: Colors.grey,
                                                    borderRadius: 10,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    cursorColor: Colors.black,
                                                    hintTextStyle:
                                                        const TextStyle(
                                                            color: Colors.grey),
                                                    context: context,
                                                    controller: controller
                                                            .nameControllersList[
                                                        index],
                                                    hintText: "Zoe Saldana",
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (controller
                                                              .nameControllersList[
                                                                  index]
                                                              .text
                                                              .isNotEmpty &&
                                                          controller
                                                              .ageControllersList[
                                                                  index]
                                                              .text
                                                              .isNotEmpty) {
                                                        controller
                                                            .userdeletechildren(
                                                                controller
                                                                        .idchildren[
                                                                    index])
                                                            .then((value) {
                                                          controller.idchildren
                                                              .removeAt(index);
                                                          controller
                                                              .nameControllersList
                                                              .removeAt(index);
                                                          controller
                                                              .ageControllersList
                                                              .removeAt(index);
                                                          // controller
                                                          //     .ageControllersList
                                                          //     .removeLast();
                                                          log("controller.nameListString :: ${controller.nameListString}");
                                                          controller.update();
                                                        });
                                                      } else {
                                                        controller
                                                            .nameControllersList[
                                                                index]
                                                            .clear();
                                                        controller
                                                            .nameControllersList
                                                            .removeLast();
                                                        controller
                                                            .ageControllersList[
                                                                index]
                                                            .clear();
                                                        controller
                                                            .ageControllersList
                                                            .removeLast();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: SizedBox(
                                                        height:
                                                            Get.height * 0.03,
                                                        width: Get.width * 0.06,
                                                        child: const Image(
                                                            image: AssetImage(
                                                                "assets/images/delete.png"))),
                                                  ),
                                                ],
                                              ),
                                              h(15),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  child: Text(
                                                    ("${LocaleKeys.labels_children.tr} ${LocaleKeys.labels_age.tr} ${index + 1}"),
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  )),
                                              h(5),
                                              Container(
                                                height: Get.height * 0.065,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Get.width * 0.03),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.00)),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: controller
                                                          .ageControllersList[
                                                      index],
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Age",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                              ],
                            );
                          },
                        );
                      }),
                      // h(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.nameControllersList
                                  .add(TextEditingController());
                              controller.ageControllersList
                                  .add(TextEditingController());
                              print(controller.nameListString);
                              controller.update();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 20, bottom: 0),
                              alignment: Alignment.center,
                              height: 35,
                              width: 110,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  )
                                  // shape: BoxShape.circle,
                                  ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Add Child",
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  w(4),
                                  const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      h(25),

                      SizedBox(
                        height: Get.height * 0.3,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.interestsList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 4),
                          itemBuilder: (context, index) {
                            return GetBuilder<EditProfileController>(
                                builder: (control) {
                              return GestureDetector(
                                  onTap: () {
                                    control.interestsList[index].isSelected =
                                        !control
                                            .interestsList[index].isSelected;
                                    control.update();
                                    if (control
                                            .interestsList[index].isSelected ==
                                        true) {
                                      controller.selectedInterestIdList
                                          .add(control.interestsList[index].id);
                                      print(controller.selectedInterestIdList);
                                    } else if (control
                                            .interestsList[index].isSelected ==
                                        false) {
                                      controller.selectedInterestIdList.remove(
                                          control.interestsList[index].id);
                                      print(controller.selectedInterestIdList);
                                    } else {}
                                    log("control.selectedInterestIdList ${control.selectedInterestIdList}");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: controller
                                              .interestsList[index].isSelected
                                          ? Colors.orange
                                          : Colors.blue,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      controller.interestsList[index].name,
                                      style: TextStyle(
                                          color: controller.interestsList[index]
                                                  .isSelected
                                              ? Colors.white
                                              : Colors.white),
                                    ),
                                  ));
                            });
                          },
                        ),
                      ),
                      h(30),
                      ButtonWithStyle(
                        onPressed: () {
                          bool contactValid =
                              RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                  .hasMatch(controller.PhoneNumber.text);
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(controller.Email.text);

                          // if (controller.imageFile == null) {
                          //   Fluttertoast.showToast(
                          //     msg: 'Please Select image',
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.blue,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0,
                          //   );
                          // } else
                          if (controller.Name.text.isEmpty) {
                            controller.fnamestatus.value = true;
                            controller.status = "Please Enter Name";
                          } else if (controller.Email.text.isEmpty) {
                            controller.emailstatus.value = true;
                            controller.status = "Please Enter Email";
                          } else if (!emailValid) {
                            controller.emailstatus.value = true;
                            controller.status = "Please Enter Valid Email";
                          } else if (controller.PhoneNumber.text.isEmpty) {
                            controller.phonestatus.value = true;
                            controller.status = "Please Enter Phone Number";
                          } else if (!contactValid) {
                            controller.phonestatus.value = true;
                            controller.status =
                                "Please Enter valid Phone Number";
                          } else if (controller.YourLocation.text.isEmpty) {
                            controller.yourLocationStatus.value = true;
                            controller.status = "Please Enter Your Location";
                          } else {
                            List<bool> validNameList = [];
                            List<bool> validAgeList = [];
                            for (var i = 0;
                                i < controller.nameControllersList.length;
                                i++) {
                              if (controller
                                      .nameControllersList[i].text.isEmpty ||
                                  controller.nameControllersList[i].text ==
                                      " ") {
                                Fluttertoast.showToast(
                                    msg: 'Please Enter Name',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                validNameList.add(true);
                              }
                            }

                            for (var i = 0;
                                i < controller.ageControllersList.length;
                                i++) {
                              if (controller
                                      .ageControllersList[i].text.isEmpty ||
                                  controller.ageControllersList[i].text ==
                                      " ") {
                                Fluttertoast.showToast(
                                    msg: 'Please Enter Name and Age',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                validAgeList.add(true);
                              }
                            }
                            // log("isNameValid : ${isNameValid}");
                            // log("isAgeValid : ${isAgeValid}");
                            if (validAgeList.length ==
                                    controller.ageControllersList.length &&
                                validNameList.length ==
                                    controller.nameControllersList.length) {
                              controller.Addprofile();
                            }
                          }
                        },
                        textVal: LocaleKeys.buttons_save.tr.toUpperCase(),
                        btnwidth: Get.width,
                      ),
                      h(Get.height * 0.1),
                    ],
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
