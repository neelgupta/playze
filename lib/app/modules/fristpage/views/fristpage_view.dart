import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/fristpage_controller.dart';

class FristpageView extends GetView<FristpageController> {
  @override
  final c = Get.put<FristpageController>(FristpageController());
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.fill
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height*0.3,
              width: Get.width*0.5,
              child: Image.asset("assets/images/logo.png"),
            )
          ],
        ),
        height: Get.height,
        width: Get.width,
      ),
    );
  }
}
