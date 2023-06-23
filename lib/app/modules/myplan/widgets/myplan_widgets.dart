import 'dart:developer';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:playze/reusability/utils/app_colors.dart';

import '../../../../generated/locales.g.dart';
import '../../../../reusability/shared/app_text_style.dart';
import '../../../../reusability/utils/util.dart';
import '../../../routes/app_pages.dart';
import '../controllers/myplan_controller.dart';

class AddPlaceButton extends StatelessWidget {
  AddPlaceButton({
    super.key,
  });
  final controller = Get.find<MyplanController>();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.ADDPLACES);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          height: Get.height * 0.09,
          width: Get.width * 0.15,
          decoration: const BoxDecoration(
              color: Color(0xffFE7702), shape: BoxShape.circle),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyPlansListview extends StatefulWidget {
  const MyPlansListview({
    super.key,
  });

  @override
  State<MyPlansListview> createState() => _MyPlansListviewState();
}

class _MyPlansListviewState extends State<MyPlansListview>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<MyplanController>();

  @override
  void initState() {
    super.initState();

    controller.dayTabBarController =
        TabController(length: controller.daysList.length, vsync: this);

    // List dsasList = [1, 2, 3];
    controller.dayTabBarController!.addListener(() {
      if (controller.dayTabBarController!.indexIsChanging) {
        // Tab Changed tapping on new tab
        //  onTabTap();
      } else if (controller.dayTabBarController!.index !=
          controller.dayTabBarController!.previousIndex) {
        // Tab Changed swiping to a new tab
        // onTabDrag();
        controller.selectedDayData =
            controller.daysList[controller.dayTabBarController!.index];
        controller.planGetlistByDayFunction();
        // log("controller.dayTabBarController!.index :${controller.dayTabBarController!.index}");

        // log("controller.selectedDay.value :${controller.selectedDay.value}");
        controller.update();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyplanController>(builder: (myPlanCon) {
      return Container(
        height: Get.height * 0.74,
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
        child: myPlanCon.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    controller: controller.dayTabBarController,
                    padding: const EdgeInsets.only(bottom: 0),
                    onTap: (day) {
                      // controller.update();
                      // Future.delayed(
                      //   const Duration(milliseconds: 20),
                      //   () {
                      //   },
                      // );
                      // log("day is : $day");

                      controller.selectedDay.value = day + 1;
                      for (var d in controller.daysList) {
                        if (d.dayNumber ==
                            controller.selectedDay.value.toString()) {
                          controller.selectedDayData = d;
                        }
                      }
                      log("controller.selectedDayData :${controller.selectedDayData!.dayNumber}");
                      controller.planGetlistByDayFunction();
                    },
                    indicator: const BoxDecoration(),
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                    tabs: controller.daysList.map((day) {
                      return Row(
                        children: [
                          const Text(
                            "Day",
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          w(8),
                          Container(
                            alignment: Alignment.center,
                            height: Get.height * 0.05,
                            width: Get.width * 0.06,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: day.dayNumber.contains(controller
                                      .selectedDayData!.dayNumber
                                      .toString())
                                  ? Colors.orange
                                  : AppColors.whiteColor,
                            ),
                            child: Text(
                              day.dayNumber,
                              style: TextStyle(
                                color: day.dayNumber.contains(controller
                                        .selectedDayData!.dayNumber
                                        .toString())
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.dayTabBarController,
                      children: controller.daysList.map((d) {
                        return myPlanCon.isPlansLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : controller.planDataList.isEmpty
                                ? const Center(
                                    child: Text(
                                      "You Have No plans.\n\nAdd some by clicking add button",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : RefreshIndicator(
                                    onRefresh: () {
                                      return controller
                                          .planGetlistByDayFunction();
                                    },
                                    child: ReorderableListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      onReorder:
                                          (int oldIndex, int newIndex) async {
                                        bool reordered = await controller
                                            .planReorderInListFunction(
                                          oldIndex: oldIndex + 1,
                                          newIndex: newIndex == 0
                                              ? newIndex + 1
                                              : newIndex,
                                        );
                                        if (newIndex > oldIndex) {
                                          newIndex -= 1;
                                        }
                                        if (reordered) {
                                          final items = controller.planDataList
                                              .removeAt(oldIndex);
                                          controller.planDataList
                                              .insert(newIndex, items);

                                          controller.update();
                                        }
                                        // if (oldIndex < newIndex) {
                                        //   newIndex -= 1;
                                        // }
                                        // final int item =
                                        //     controller.items.removeAt(oldIndex);
                                        // controller.items.insert(newIndex, item);
                                      },
                                      shrinkWrap: true,
                                      itemCount: controller.planDataList.length,
                                      itemBuilder: (context, index) {
                                        var singlePlan =
                                            controller.planDataList[index];
                                        return Padding(
                                          key: Key('$index'),
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: Column(
                                            children: [
                                              // controller.planDataList.length -
                                              //             1 ==
                                              //         index
                                              //     ? const SizedBox()
                                              //     :
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.08,
                                                      width: Get.width * 0.02,
                                                      child: Image.asset(
                                                          "assets/images/Line.png"),
                                                    ),
                                                    w(10),
                                                    SizedBox(
                                                      height: Get.height * 0.08,
                                                      width: Get.width * 0.04,
                                                      child: Image.asset(
                                                          "assets/images/Blueman.png"),
                                                    ),
                                                    w(10),
                                                    Text(
                                                      singlePlan.duration,
                                                      // "2 min by walking",
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // margin:
                                                //     const EdgeInsets.only(bottom: 15),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors.greyColor
                                                          .withOpacity(0.12),
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 121,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              const BoxDecoration(
                                                            // image: DecorationImage(
                                                            //     image: AssetImage(
                                                            //         "assets/images/pic.png"),
                                                            //     fit: BoxFit.fill),
                                                            color: Colors.cyan,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                            ),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      singlePlan
                                                                          .placeImage,
                                                                  height: 121,
                                                                  width: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorWidget:
                                                                      (context,
                                                                          url,
                                                                          error) {
                                                                    return const Center(
                                                                      child:
                                                                          Text(
                                                                        "Image Not Loaded",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.blackColor,
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 12,
                                                                left: 12,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration: const BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20))),
                                                                      height: Get
                                                                              .height *
                                                                          0.04,
                                                                      width: Get
                                                                              .width *
                                                                          0.15,
                                                                      child:
                                                                          Text(
                                                                        singlePlan
                                                                            .startTime,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            6),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          isScrollControlled:
                                                                              true,
                                                                          shape:
                                                                              const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topLeft: Radius.circular(20),
                                                                              topRight: Radius.circular(20),
                                                                            ),
                                                                          ),
                                                                          constraints:
                                                                              BoxConstraints(maxHeight: Get.size.height * 0.7),
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return BottomEditPlanBody(
                                                                              planId: singlePlan.id,
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.all(7),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                        height: Get.height *
                                                                            0.04,
                                                                        width: Get.width *
                                                                            0.1,
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/images/edit-line.png",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 15,
                                                                right: 15,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    // if (singlePlan
                                                                    //     .isfavorite) {
                                                                    //   controller
                                                                    //       .removeFromWishListFunction(
                                                                    //     placeId:
                                                                    //         singlePlan.id,
                                                                    //   );
                                                                    // } else {
                                                                    //   await controller
                                                                    //       .addTowishListFunction(
                                                                    //     placeId:
                                                                    //         singlePlan.id,
                                                                    //   );
                                                                    // }
                                                                  },
                                                                  child: singlePlan
                                                                          .isfavorite
                                                                      ? Image
                                                                          .asset(
                                                                          "assets/images/dil2.png",
                                                                          color:
                                                                              AppColors.redColor,
                                                                          height:
                                                                              24,
                                                                          width:
                                                                              24,
                                                                        )
                                                                      : Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/dil.png",
                                                                            color:
                                                                                AppColors.whiteColor,
                                                                            height:
                                                                                18,
                                                                            width:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 12),
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 12,
                                                                right: 12,
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    singlePlan
                                                                        .placeName,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                  h(8),
                                                                  Text(
                                                                    singlePlan
                                                                        .placeDescription,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  h(10),
                                                                  Divider(
                                                                    color: AppColors
                                                                        .blackColor
                                                                        .withOpacity(
                                                                            0.5),
                                                                    thickness:
                                                                        1,
                                                                    height: 1,
                                                                  ),
                                                                  h(10),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        // width: Get.width * 0.3,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            // controller
                                                                            //     .gotoMapPlaceLocation(placeId: singlePlan.id);
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                padding: const EdgeInsets.all(7),
                                                                                alignment: Alignment.center,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                                ),
                                                                                height: Get.height * 0.04,
                                                                                width: Get.width * 0.1,
                                                                                child: Image.asset("assets/images/Navigate.png"),
                                                                              ),
                                                                              w(10),
                                                                              const Text(
                                                                                "Navigate",
                                                                                style: TextStyle(fontSize: 14),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        // width: Get.width * 0.3,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                                padding: const EdgeInsets.all(7),
                                                                                alignment: Alignment.center,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                                ),
                                                                                height: Get.height * 0.04,
                                                                                width: Get.width * 0.1,
                                                                                child: Image.asset("assets/images/clock.png")),
                                                                            w(10),
                                                                            Text(
                                                                              singlePlan.time,
                                                                              style: const TextStyle(
                                                                                fontSize: 14,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  h(10),
                                                                ],
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 10,
                                                              top: 0,
                                                              child: Text(
                                                                singlePlan
                                                                    .changeDuration,
                                                                // "1 hours 30 mins",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 13,
                                                                  color: AppColors
                                                                      .greyColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    // controller.planDataList.length -
                                                    //             1 ==
                                                    //         index
                                                    //     ? const SizedBox()
                                                    //     : Container(
                                                    //         padding:
                                                    //             const EdgeInsets.only(
                                                    //                 left: 20),
                                                    //         child: Row(
                                                    //           children: [
                                                    //             SizedBox(
                                                    //               height: Get.height *
                                                    //                   0.08,
                                                    //               width: Get.width *
                                                    //                   0.02,
                                                    //               child: Image.asset(
                                                    //                   "assets/images/Line.png"),
                                                    //             ),
                                                    //             w(10),
                                                    //             SizedBox(
                                                    //               height: Get.height *
                                                    //                   0.08,
                                                    //               width: Get.width *
                                                    //                   0.04,
                                                    //               child: Image.asset(
                                                    //                   "assets/images/Blueman.png"),
                                                    //             ),
                                                    //             w(5),
                                                    //             Text(
                                                    //               singlePlan.duration,
                                                    //               // "2 min by walking",
                                                    //               style:
                                                    //                   const TextStyle(
                                                    //                       fontSize:
                                                    //                           12),
                                                    //             )
                                                    //           ],
                                                    //         ),
                                                    //       ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                      }).toList(),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}

class BottomEditPlanBody extends StatelessWidget {
  BottomEditPlanBody({
    super.key,
    required this.planId,
  });

  final String planId;
  final controller = Get.find<MyplanController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              LocaleKeys.labels_Edit.tr,
              style: TextStyle(
                  fontSize: 18, color: AppColors.blackColor.withOpacity(0.7)),
            ),
            h(20),
            GestureDetector(
              onTap: () {
                controller.makeStartTimeList();
                Get.back();

                showFlexibleBottomSheet(
                  minHeight: 0,
                  initHeight: 0.98,
                  maxHeight: 1,
                  isModal: true,
                  isExpand: true,
                  isSafeArea: true,
                  barrierColor: AppColors.blackColor.withOpacity(0.35),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20)),
                  ),
                  bottomSheetColor: AppColors.whiteColor,
                  context: context,
                  builder: (context, scrollController, bottomSheetOffset) {
                    return StartTimeListviewBody(
                      planId: planId,
                    );
                  },
                  // anchors: [0, 0.5, 1],
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: AppColors.greyColor.withOpacity(0.85),
                  ),
                ),
                width: Get.width,
                height: 42,
                child: Text(
                  LocaleKeys.buttons_Change_Start_Time.tr.toUpperCase(),
                  style: AppTextStyle.size14Medium
                      .copyWith(color: AppColors.greyColor.withOpacity(0.85)),
                ),
              ),
            ),
            h(15),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.dialog(
                  Material(
                    type: MaterialType.transparency,
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        height: 200,
                        width: Get.size.width * 0.85,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: AppColors.greyColor.withOpacity(0.254),
                              height: 1,
                              thickness: 1,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  "Are your sure want to remove this place from your itienary ?",
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.greyColor.withOpacity(0.254),
                              height: 1,
                              thickness: 1,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.whiteColor,
                                        foregroundColor: AppColors.primaryColor,
                                      ),
                                      child: const Text(
                                        "No",
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                    color:
                                        AppColors.greyColor.withOpacity(0.254),
                                    thickness: 1,
                                    width: 1,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Get.back();
                                        controller.deletePlanFromList(
                                          planId: planId,
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.whiteColor,
                                        foregroundColor: AppColors.primaryColor,
                                      ),
                                      child: const Text("Yes"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  transitionCurve: Curves.linear,
                  transitionDuration: const Duration(milliseconds: 400),
                  barrierDismissible: false,
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.85))),
                width: Get.width,
                height: 42,
                child: Text(
                  LocaleKeys.buttons_Remove.tr.toUpperCase(),
                  style: AppTextStyle.size14Medium
                      .copyWith(color: AppColors.greyColor.withOpacity(0.85)),
                ),
              ),
            ),
            h(15),
            GestureDetector(
              onTap: () {
                controller.makeChangeDurationList();
                Get.back();

                showFlexibleBottomSheet(
                  minHeight: 0,
                  initHeight: 0.98,
                  maxHeight: 1,
                  isModal: true,
                  isExpand: true,
                  isSafeArea: true,
                  barrierColor: AppColors.blackColor.withOpacity(0.35),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20)),
                  ),
                  bottomSheetColor: AppColors.whiteColor,
                  context: context,
                  builder: (context, scrollController, bottomSheetOffset) {
                    return ChangeDurationListviewBody(
                      planId: planId,
                    );
                  },
                  // anchors: [0, 0.5, 1],
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.85))),
                width: Get.width,
                height: 42,
                child: Text(
                  LocaleKeys.buttons_Change_Duration.tr.toUpperCase(),
                  style: AppTextStyle.size14Medium
                      .copyWith(color: AppColors.greyColor.withOpacity(0.85)),
                ),
              ),
            ),
            h(15),
            GestureDetector(
              onTap: () {
                controller.makeChangeDayList();
                Get.back();

                showFlexibleBottomSheet(
                  minHeight: 0,
                  initHeight: 0.98,
                  maxHeight: 1,
                  isModal: true,
                  isExpand: true,
                  isSafeArea: true,
                  barrierColor: AppColors.blackColor.withOpacity(0.35),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20)),
                  ),
                  bottomSheetColor: AppColors.whiteColor,
                  context: context,
                  builder: (context, scrollController, bottomSheetOffset) {
                    return ChangeDayListviewBody(planId: planId);
                  },
                  // anchors: [0, 0.5, 1],
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.85))),
                width: Get.width,
                height: 42,
                child: Text(
                  LocaleKeys.buttons_Change_Day.tr.toUpperCase(),
                  style: AppTextStyle.size14Medium
                      .copyWith(color: AppColors.greyColor.withOpacity(0.85)),
                ),
              ),
            ),
            h(15),
            GestureDetector(
              onTap: () {
                // controller.reorderDayList();
                Get.back();

                showFlexibleBottomSheet(
                  minHeight: 0,
                  initHeight: 0.98,
                  maxHeight: 1,
                  isModal: true,
                  isExpand: true,
                  isSafeArea: true,
                  barrierColor: AppColors.blackColor.withOpacity(0.35),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20)),
                  ),
                  bottomSheetColor: AppColors.whiteColor,
                  context: context,
                  builder: (context, scrollController, bottomSheetOffset) {
                    return ReorderDayListviewBody();
                  },
                  // anchors: [0, 0.5, 1],
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.85))),
                width: Get.width,
                height: 42,
                child: Text(
                  LocaleKeys.buttons_Change_Order.tr.toUpperCase(),
                  style: AppTextStyle.size14Medium
                      .copyWith(color: AppColors.greyColor.withOpacity(0.85)),
                ),
              ),
            ),
            h(15),
            GestureDetector(
              onTap: () {
                controller.makeManageDaysList();
                Get.back();

                showFlexibleBottomSheet(
                  minHeight: 0,
                  initHeight: 0.98,
                  maxHeight: 1,
                  isModal: true,
                  isExpand: true,
                  isSafeArea: true,
                  barrierColor: AppColors.blackColor.withOpacity(0.35),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20)),
                  ),
                  bottomSheetColor: AppColors.whiteColor,
                  context: context,
                  builder: (context, scrollController, bottomSheetOffset) {
                    return ManageDaysListviewBody();
                  },
                  // anchors: [0, 0.5, 1],
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: AppColors.greyColor.withOpacity(0.85))),
                width: Get.width,
                height: 42,
                child: Text(
                  LocaleKeys.buttons_Manage_Days.tr.toUpperCase(),
                  style: AppTextStyle.size14Medium
                      .copyWith(color: AppColors.greyColor.withOpacity(0.85)),
                ),
              ),
            ),
            h(15),
            ButtonWithStyle(
              onPressed: () {
                Get.back();
              },
              btnheight: 42,
              textVal: LocaleKeys.buttons_Cancel.tr.toUpperCase(),
              btnwidth: Get.width,
            ),
          ],
        ),
      ),
    );
  }
}

class StartTimeListviewBody extends StatelessWidget {
  StartTimeListviewBody({
    super.key,
    required this.planId,
  });

  final String planId;
  final controller = Get.find<MyplanController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.blackColor,
            ),
          ),
          title: const Text("Start Time"),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.greyColor.withOpacity(0.35),
        ),
        Expanded(
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.startTimeList.length,
                    itemBuilder: (context, index) {
                      var singleTime = controller.startTimeList[index];
                      String displayTime =
                          DateFormat("h:mmaa").format(singleTime);
                      String apiSendTime =
                          DateFormat("hh:mm").format(singleTime);

                      return ListTile(
                        dense: true,
                        onTap: () {
                          controller.changeStartTimeOfPlanInDayApiMethod(
                            planId: planId,
                            dayNumber: controller.selectedDayData!.dayNumber,
                            startTime: apiSendTime,
                          );
                        },
                        title: Text(
                          displayTime.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.greyColor.withOpacity(0.25),
                        indent: 5,
                        endIndent: 5,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class ChangeDurationListviewBody extends StatelessWidget {
  ChangeDurationListviewBody({super.key, required this.planId});

  final String planId;
  final controller = Get.find<MyplanController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.blackColor,
            ),
          ),
          title: const Text("Visit Duration"),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.greyColor.withOpacity(0.35),
        ),
        Expanded(
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.changeDurationList.length,
                    itemBuilder: (context, index) {
                      var singleHour = controller.changeDurationList[index];
                      // String displayTime = DateFormat("h:mmaa").format(singleTime);
                      // final now = DateTime.now();
                      // final dt = DateTime(now.year, now.month, now.day, singleHour.hour,
                      //     singleHour.minute);
                      // final hmFormat = DateFormat("hh:mm"); //"6:00 AM"
                      // return format.format(dt);

                      return ListTile(
                        dense: true,
                        onTap: () {
                          controller.changeTimeDurationOfPlanInDayApiMethod(
                            planId: planId,
                            dayNumber: controller.selectedDayData!.dayNumber,
                            durationTime: singleHour.to24hours(),
                            // "${singleHour.hour}:${singleHour.minute}",
                          );
                        },
                        title: Text(
                          singleHour.hour == 0
                              ? "${singleHour.minute} minutes"
                              : singleHour.minute == 0
                                  ? "${singleHour.hour} hour"
                                  : "${singleHour.hour} hour ${singleHour.minute} minutes",
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.greyColor.withOpacity(0.25),
                        indent: 5,
                        endIndent: 5,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class ChangeDayListviewBody extends StatelessWidget {
  ChangeDayListviewBody({super.key, required this.planId});

  final String planId;

  final controller = Get.find<MyplanController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.blackColor,
            ),
          ),
          title: const Text("Change day for place"),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.greyColor.withOpacity(0.35),
        ),
        Expanded(
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.daysList.length,
                    itemBuilder: (context, index) {
                      var singleDay = controller.daysList[index];
                      // String displayTime = DateFormat("h:mmaa").format(singleTime);

                      return ListTile(
                        dense: true,
                        onTap: () {},
                        title: Text(
                          singleDay.dayNumber.contains(
                                  controller.selectedDay.value.toString())
                              ? "${singleDay.day} (current)"
                              : singleDay.day,
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 20, right: 5),
                        trailing: IconButton(
                          onPressed: () {
                            controller.dayPlanChangeFunction(
                              planId: planId,
                              dayNumber: singleDay.dayNumber,
                            );
                          },
                          icon: const Icon(
                            Icons.play_circle_outline_outlined,
                            color: AppColors.blackColor,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.greyColor.withOpacity(0.25),
                        indent: 5,
                        endIndent: 5,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class ReorderDayListviewBody extends StatelessWidget {
  ReorderDayListviewBody({super.key});

  final controller = Get.find<MyplanController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.blackColor,
            ),
          ),
          title: const Text("Change day for place"),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.greyColor.withOpacity(0.35),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            "Drag and drop places : ",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.greyColor.withOpacity(0.35),
        ),
        Expanded(
          child: GetBuilder<MyplanController>(builder: (cont) {
            return Obx(
              () => cont.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : cont.isPlansLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ReorderableListView.builder(
                          onReorder: (oldIndex, newIndex) async {
                            // if (newIndex > oldIndex) {
                            //   newIndex -= 1;
                            // }
                            bool reordered =
                                await controller.planReorderInListFunction(
                              oldIndex: oldIndex + 1,
                              newIndex: newIndex,
                            );
                            if (reordered) {
                              // if (newIndex > oldIndex) {
                              //   newIndex -= 1;
                              // }
                              final items =
                                  controller.planDataList.removeAt(oldIndex);
                              controller.planDataList.insert(newIndex, items);

                              controller.update();
                            }
                          },
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.planDataList.length,
                          itemBuilder: (context, index) {
                            var singlePlace = controller.planDataList[index];
                            var singlePlaceKey =
                                controller.reorderPlacesKeyList[index];
                            // String displayTime = DateFormat("h:mmaa").format(singleTime);
                            log("singlePlace name  :: ${singlePlace.placeName}");
                            return Card(
                              key: ValueKey(singlePlaceKey),
                              child: Column(
                                children: [
                                  ListTile(
                                    dense: true,
                                    onTap: () {},
                                    title: Text(
                                      singlePlace.placeName,
                                      style: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    horizontalTitleGap: 0,
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, right: 5),
                                    leading: const Icon(
                                      Icons.menu,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color:
                                        AppColors.greyColor.withOpacity(0.25),
                                    indent: 5,
                                    endIndent: 5,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
            );
          }),
        ),
      ],
    );
  }
}

class ManageDaysListviewBody extends StatelessWidget {
  ManageDaysListviewBody({super.key});

  final controller = Get.find<MyplanController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.blackColor,
            ),
          ),
          title: const Text("Manage Days"),
        ),
        Expanded(
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 85,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.whiteColor,
                                foregroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // controller.day.add("Day New (empty)");
                                controller.addDayToList();
                              },
                              child: const Text(
                                "Add Day",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<MyplanController>(
                        builder: (context) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.daysList.length,
                            itemBuilder: (context, index) {
                              var singleDay = controller.daysList[index];
                              // String displayTime = DateFormat("h:mmaa").format(singleTime);

                              return ListTile(
                                dense: true,
                                // onTap: () {},
                                title: Text(
                                  // singleDay.contains(controller.selectedDay.value)
                                  //     ? "Day  (current)"
                                  //     :
                                  singleDay.day,
                                  style: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(left: 20, right: 5),
                                leading: const Icon(
                                  Icons.menu,
                                  color: AppColors.blackColor,
                                ),
                                horizontalTitleGap: 0,
                                trailing: IconButton(
                                  onPressed: () {
                                    // controller.daysList.removeAt(index);
                                    controller.deleteDayFromList(
                                        dayNumber: singleDay.dayNumber);
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    size: 25,
                                    color:
                                        AppColors.blackColor.withOpacity(0.8),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.greyColor.withOpacity(0.25),
                                indent: 5,
                                endIndent: 5,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
