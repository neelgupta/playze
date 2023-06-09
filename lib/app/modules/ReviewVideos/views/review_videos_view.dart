import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/review_videos_controller.dart';

class ReviewVideosView extends GetView<ReviewVideosController> {
  const ReviewVideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GetBuilder<ReviewVideosController>(
          builder: (controller) => controller.chewieController != null &&
                  controller.chewieController!.videoPlayerController.value
                      .isInitialized
              ? Chewie(
                  controller: controller.chewieController!,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      // bottomNavigationBar: const btmbar(fromOther: true),
      // extendBody: true,
    );
  }
}
