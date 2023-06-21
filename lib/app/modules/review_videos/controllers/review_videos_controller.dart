import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ReviewVideosController extends GetxController {
  final count = 0.obs;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  var args = Get.arguments;

  bool isNetwork = true;
  var videosUrl = "";

  @override
  void onInit() {
    super.onInit();

    var arguments = args as List;
    if (arguments.length > 1) {
      isNetwork = args[1];
    }

    initplayer();
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

    if (isNetwork) {
      videoPlayerController = VideoPlayerController.network(videosUrl)
        ..initialize().then((_) {
          update();
        });
    } else {
      videoPlayerController = VideoPlayerController.file(File(videosUrl))
        ..initialize().then((_) {
          update();
        });
    }
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
