import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../../Reusability/shared/commonTextField.dart';
import '../../../../Reusability/utils/app_colors.dart';
import '../controllers/childinfo_controller.dart';

class ChildinfoView extends GetView<ChildinfoController> {
  const ChildinfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: Get.width * 0.4,
                            child: Image.asset("assets/images/appIcon.png")),
                        h(20),
                        Text(
                          LocaleKeys.text_create_account.tr,
                          style: AppTextStyle.size18Medium.copyWith(
                              letterSpacing: 1.8,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        h(20),
                        GetBuilder<ChildinfoController>(builder: (cont) {
                          return ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => h(20),
                            itemCount: controller.weekPrice.length + 1,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              LocaleKeys
                                                  .labels_Children_information
                                                  .tr,
                                              style: AppTextStyle.size18Medium
                                                  .copyWith(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        h(20),
                                        Text(
                                          LocaleKeys
                                              .text_Create_Account_nots.tr,
                                          style: AppTextStyle.size18Medium
                                              .copyWith(fontSize: 12),
                                        ),
                                        h(20),
                                        SizedBox(
                                          height: Get.height * 0.065,
                                          width: double.infinity,
                                          child: InputTextField(
                                            onChanged: () {
                                              controller.cnamestatus.value =
                                                  false;
                                            },
                                            context: context,
                                            controller: controller
                                                .nameControllersList[index],
                                            hintText:
                                                "${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_name.tr}",
                                          ),
                                        ),
                                        Obx(
                                          () => controller.cnamestatus.value
                                              ? SizedBox(
                                                  child: Text(
                                                    controller.status,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                        h(15),
                                        Container(
                                          height: Get.height * 0.065,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.03),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5.00)),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) => () {
                                              controller.cagestatus.value =
                                                  false;
                                            },
                                            style: const TextStyle(
                                                color: Colors.white),
                                            cursorColor: Colors.white,
                                            controller: controller
                                                .ageControllersList[index],
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    "${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_age.tr}",
                                                hintStyle:
                                                    AppTextStyle.size12Regular),
                                          ),
                                        ),
                                        Obx(
                                          () => controller.cagestatus.value
                                              ? SizedBox(
                                                  child: Text(
                                                    controller.status,
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: Get.height * 0.065,
                                                width: double.infinity,
                                                child: InputTextField(
                                                  onChanged: () {
                                                    controller.cnamestatus
                                                        .value = false;
                                                  },
                                                  width: Get.width * 0.8,
                                                  context: context,
                                                  controller: controller
                                                          .nameControllersList[
                                                      index],
                                                  hintText:
                                                      "${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_name.tr}",
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Obx(
                                              () => controller.cnamestatus.value
                                                  ? SizedBox(
                                                      child: Text(
                                                        controller.status,
                                                        style: const TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    )
                                                  : Container(),
                                            ),
                                            GestureDetector(
                                              onTap: (() {
                                                controller.weekPrice
                                                    .removeAt(index - 1);
                                                controller.nameControllersList
                                                    .removeAt(index - 1);
                                                controller.ageControllersList
                                                    .removeAt(index - 1);
                                                // controller.nameControllersList
                                                //     .removeLast();
                                                // controller
                                                //     .ageControllersList[index]
                                                //     .clear();
                                                // controller
                                                //     .nameControllersList[index]
                                                //     .dispose();
                                                // controller
                                                //     .ageControllersList[index]
                                                //     .dispose();
                                                controller.update();
                                              }),
                                              child: SizedBox(
                                                  height: Get.height * 0.06,
                                                  width: Get.width * 0.05,
                                                  child: Image.asset(
                                                    "assets/images/delete.png",
                                                    color: Colors.white,
                                                  )),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        h(15),
                                        Container(
                                          height: Get.height * 0.065,
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.03),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5.00)),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) => () {
                                              controller.cagestatus.value =
                                                  false;
                                            },
                                            controller: controller
                                                .ageControllersList[index],
                                            style: const TextStyle(
                                                color: AppColors.whiteColor),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    "${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_age.tr}",
                                                hintStyle:
                                                    AppTextStyle.size12Regular),
                                          ),
                                        ),
                                        Obx(
                                          () => controller.cagestatus.value
                                              ? SizedBox(
                                                  child: Text(
                                                    controller.status,
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                      ],
                                    );
                            },
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.weekPrice
                                    .add((controller.weekPrice.length + 1) + 1);
                                controller.nameControllersList
                                    .add(TextEditingController());
                                controller.ageControllersList
                                    .add(TextEditingController());
                                controller.update();
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 0),
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
                        h(20),
                        Text("Interest ",
                            style: AppTextStyle.size18Medium
                                .copyWith(fontSize: 16)),
                        h(10),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.interestsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 4),
                          itemBuilder: (context, index) {
                            return GetBuilder<ChildinfoController>(
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
                                          ? Colors.white
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
                                              ? Colors.blue
                                              : Colors.white),
                                    ),
                                  ));
                            });
                          },
                        ),
                        h(40),
                        ButtonWithStyle(
                          onPressed: () {
                            for (var namecon
                                in controller.nameControllersList) {
                              if (namecon.text.isEmpty || namecon.text == " ") {
                                controller.isChildDataValid.value = false;
                                Fluttertoast.showToast(
                                  msg: 'Please Enter child name',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                controller.isChildDataValid.value = true;
                              }
                            }

                            for (var agecon in controller.ageControllersList) {
                              if (agecon.text.isEmpty || agecon.text == " ") {
                                controller.isChildDataValid.value = false;
                                Fluttertoast.showToast(
                                  msg: 'Please Enter child age',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                controller.isChildDataValid.value = true;
                              }
                            }
                            if (controller.isChildDataValid.value) {
                              if (controller.nameControllersList.isEmpty) {
                                controller.cnamestatus.value = true;
                                // controller.status = "please enter ChildrenName";
                              } else if (controller
                                  .ageControllersList.isEmpty) {
                                controller.cagestatus.value = true;
                                // controller.status = "please enter Childrenage";
                              } else {
                                controller.signUp(context);
                              }
                            }
                          },
                          textVal: LocaleKeys.buttons_sign_up.tr.toUpperCase(),
                          btnwidth: Get.width,
                        ),
                        h(10),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: LocaleKeys.text_already_have_account.tr,
                                style: AppTextStyle.size12Medium),
                            TextSpan(
                                text: " ${LocaleKeys.buttons_log_in.tr}",
                                style: AppTextStyle.size12Medium.copyWith(
                                    color: Colors.orange,
                                    decoration: TextDecoration.underline,
                                    height: 1.5),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.back();
                                  }),
                          ])),
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
