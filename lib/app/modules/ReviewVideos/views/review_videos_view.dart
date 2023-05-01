import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';

import '../controllers/review_videos_controller.dart';

class ReviewVideosView extends GetView<ReviewVideosController> {
  const ReviewVideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(150),
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/enjoy.png"),fit: BoxFit.fill,)
            ),
            child: Image.asset("assets/images/videoplay.png",),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: Get.height * 0.07,
                    decoration: BoxDecoration(
                    ),
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image(
                            image:
                            AssetImage("assets/images/back.png"),
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Review Videos",
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
      bottomNavigationBar: btmbar(fromOther: true),
      extendBody: true,
    );
  }
}
