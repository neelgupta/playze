import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../Reusability/shared/drawer.dart';


class ReviewVideosController extends GetxController {
  //TODO: Implement ReviewVideosController

  final count = 0.obs;
  late VideoPlayerController videoPlayerController;
   ChewieController? chewieController;


  var args = Get.arguments;

  var videosUrl  ="";

  @override
  void onInit() {
    super.onInit();
    initplayer();
    print(chewieController);
    print(videoPlayerController);
    videosUrl=args[0];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController.dispose();
    chewieController?.dispose();
  }

 Future<void> initplayer()async{
   videoPlayerController = VideoPlayerController.network(
       "${videosUrl}");
   await videoPlayerController.initialize();
   chewieController = ChewieController(videoPlayerController: videoPlayerController,

   );
   update();
 }
}
