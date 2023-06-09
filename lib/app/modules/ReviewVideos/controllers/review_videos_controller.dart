import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ReviewVideosController extends GetxController {
  //TODO: Implement ReviewVideosController

  final count = 0.obs;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  var args = Get.arguments;

  var videosUrl = "";

  @override
  void onInit() {
    super.onInit();

    initplayer();
    // print(chewieController);
    // print(videoPlayerController);
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController.dispose();
    chewieController?.dispose();
  }

  Future<void> initplayer() async {
    videosUrl = args[0];
    log("videosUrl :$videosUrl");
    // VideoPlayerController.network();
    videoPlayerController = VideoPlayerController.network(videosUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        // setState(() {});

        update();
      });
    // await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      showOptions: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
    update();
  }
}
