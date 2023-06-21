import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/first_page_controller.dart';

class FristpageView extends GetView<FirstPageController> {
  FristpageView({super.key});

  final c = Get.put<FirstPageController>(FirstPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/splash.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.3,
              width: Get.width * 0.5,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
