import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:video_player/video_player.dart';

import '../controllers/review_videos_controller.dart';

class ReviewVideosView extends GetView<ReviewVideosController> {
  const ReviewVideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetBuilder<ReviewVideosController>(
            init: ReviewVideosController(),
            builder: (controller)=>
                Container(
                  height: Get.height*0.9,
                  child: controller.chewieController!= null && controller.chewieController!.videoPlayerController.value.isInitialized?
                      Chewie(controller:controller.chewieController!):
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                )
        ),
      ),
      bottomNavigationBar: btmbar(fromOther: true),
      extendBody: true,
    );
  }
}
