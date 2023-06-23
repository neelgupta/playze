import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_drawer.dart';

import '../../../../reusability/utils/app_colors.dart';
import '../controllers/myplan_controller.dart';
import '../widgets/myplan_widgets.dart';

class MyplanView extends GetView<MyplanController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  final controller = Get.put<MyplanController>(MyplanController());

  MyplanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _key,
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
                        _key.currentState!.openDrawer();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              child: const Image(
                                image: AssetImage("assets/images/menu.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "My Plan",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // GestureDetector(
                    //   onTap: () {
                    //     //search func
                    //   },
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(horizontal: 10),
                    //     // decoration: const BoxDecoration(),
                    //     child: Center(
                    //       child: Image.asset(
                    //         "assets/images/search.png",
                    //         height: 20,
                    //         width: 20,
                    //         color: AppColors.whiteColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        //share func
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        // decoration: const BoxDecoration(),
                        child: Center(
                          child: Image.asset(
                            "assets/images/share.png",
                            height: 24,
                            width: 24,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //mapview  func
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        // decoration: const BoxDecoration(),
                        child: Center(
                          child: Image.asset(
                            "assets/images/mapviwe.png",
                            height: 20,
                            width: 20,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //more func
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        // decoration: const BoxDecoration(),
                        child: Center(
                          child: Image.asset(
                            "assets/images/more3.png",
                            height: 20,
                            width: 20,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const CustomStartDrawer(),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.permission == LocationPermission.whileInUse ||
                    controller.permission == LocationPermission.always
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          const MyPlansListview(),
                          AddPlaceButton(),
                        ],
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      "Allow location permission in your settings",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
      ),
    );
  }
}
