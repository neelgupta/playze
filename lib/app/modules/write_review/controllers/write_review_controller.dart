import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playze/app/data/service/user_service.dart';
import 'package:playze/app/modules/place_full_details/controllers/place_full_details_controller.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import '../../../../reusability/utils/shared_prefs.dart';
import '../../../data/service/api_url_list.dart';

class WriteReviewController extends GetxController {
  final count = 0.obs;
  var args = Get.arguments;
  String placeId = "";
  TextEditingController reviewController = TextEditingController();
  File? imageFile;
  File? imagevideoFile;
  var isImagePicked = false.obs;
  var isVideoPicked = false.obs;
  var isLoading = false.obs;
  RxDouble ratingValue = 0.0.obs;

  GlobalKey<FormState> reviewFormKey = GlobalKey<FormState>();
  List<ImageFile> imageFiles = [];
  List<VideoFile> videoFiles = [];

  UserService userService = UserService();

  @override
  void onInit() {
    super.onInit();

    if (args != null) {
      placeId = args[0];
    }
    log("gort placeId si  $placeId");
  }

  void removeImageFromList(int index) {
    isLoading(true);
    imageFiles.removeAt(index);
    isLoading(false);
  }

  void removeVideoFromList(int index) {
    isLoading(true);
    videoFiles.removeAt(index);
    isLoading(false);
  }

  showPickerBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SizedBox(
          height: Get.size.height * 0.18,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Get.back();
                  selectImageFiles();
                },
                title: const Text("Pick Images"),
              ),
              ListTile(
                onTap: () {
                  Get.back();
                  selectVideoFiles();
                },
                title: const Text("Pick Videos"),
              ),
            ],
          ),
        );
      },
    );
  }

  void selectImageFiles() async {
    ImagePicker picker = ImagePicker();
    List<XFile>? result = await picker.pickMultiImage(
      imageQuality: 85,

      // allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    try {
      isLoading.value = true;

      // final ImagePicker picker = ImagePicker();
      // XFile? file = await picker.pickVideo(source: ImageSource.gallery);
      imageFiles.clear();
      // imagevideoFile = File(result.);

      for (var file in result) {
        log("file.path! :: ${file.path}");

        // log("file.bytes :: ${file.bytes!}");
        imageFiles.add(
          ImageFile(
            filePath: file.path,

            // fileInBytes: [],
          ),
        );
      }

      isImagePicked.value = true;
    } catch (e) {
      log("e ${e.toString()}");
      rethrow;
    } finally {
      update();
      isLoading.value = false;
    }
  }

  void selectVideoFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,

      // allowedExtensions: ['jpg', 'pdf', 'doc'],
      allowCompression: true,
      allowMultiple: true,
      dialogTitle: "Pick Videos",
      // lockParentWindow: true,
    );
    try {
      isLoading.value = true;

      // final ImagePicker picker = ImagePicker();
      // XFile? file = await picker.pickVideo(source: ImageSource.gallery);
      if (result != null) {
        videoFiles.clear();
        // imagevideoFile = File(result.);

        for (var file in result.files) {
          final thumbnailPath = await VideoThumbnail.thumbnailFile(
              video: file.path!,
              imageFormat: ImageFormat.JPEG,
              timeMs: 1,
              quality: 50);

          // log("file.bytes :: ${file.bytes!}");
          videoFiles.add(
            VideoFile(
              filePath: file.path!,
              thumbnailPath: thumbnailPath!,
              // fileInBytes: [],
            ),
          );
        }

        isVideoPicked.value = true;
      }
    } catch (e) {
      log("e ${e.toString()}");
      rethrow;
    } finally {
      update();
      isLoading.value = false;
    }
  }

  Future<void> addReviewApi() async {
    isLoading(true);
    List<String>? tokan =
        SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");

    try {
      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      var url = Uri.parse(ApiUrlList.addReview);
      String newtokan = tokan![1];

      var reqBody = {
        "places_id": placeId,
        "user_id": userId.toString(),
        "rating": ratingValue.value.toString(),
        "review": reviewController.text.trim(),
      };

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $newtokan"
      };

      // log("addWorkSpaceToMyWorkSpace reqBody :: $reqBody");
      http.MultipartRequest request = http.MultipartRequest(
        "POST",
        url,
      );

      request.headers.addAll(headers);
      request.fields.addAll(reqBody);

      List<http.MultipartFile> newVideosList = [];

      for (var vid in videoFiles) {
        if (vid.filePath != "") {
          var multipartFile = await http.MultipartFile.fromPath(
            'image_video[]',
            vid.filePath,
            // filename: vid.filePath.split('/').last,
          );
          newVideosList.add(multipartFile);
        }
      }

      request.files.addAll(newVideosList);

      List<http.MultipartFile> newImagesList = [];

      for (var img in imageFiles) {
        if (img.filePath != "") {
          var multipartFile = await http.MultipartFile.fromPath(
            'image_video[]',
            img.filePath,
            // filename: vid.filePath.split('/').last,
          );
          newImagesList.add(multipartFile);
        }
      }

      request.files.addAll(newImagesList);

      log("request.url = ${request.url}");
      log("request.headers = ${request.headers}");
      log("request.fields = ${request.fields}");
      log("request.files = ${request.files}");

      var response = await request.send();
      log("response.statusCode = ${response.statusCode}");

      http.Response result = await http.Response.fromStream(response);

      if (result.statusCode == 200) {
        log("result.body :: ${result.body}");
        var resBody = jsonDecode(result.body);
        if (resBody["status"] == 200) {
          Get.back();

          var placeFullDetailsController =
              Get.find<PlaceFullDetailsController>();

          placeFullDetailsController.viewMoreReviews.value = false;
          placeFullDetailsController.getPlaceReviewsList();
          Fluttertoast.showToast(
            msg: 'Review Added Successfully.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: resBody["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Something went wrong. Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}

class ImageFile {
  final String filePath;

  Uint8List? fileInBytes;
  // final String filePath;

  ImageFile({
    required this.filePath,
    this.fileInBytes,
  });
}

class VideoFile {
  final String filePath;
  final String thumbnailPath;
  Uint8List? fileInBytes;
  // final String filePath;

  VideoFile({
    required this.filePath,
    required this.thumbnailPath,
    this.fileInBytes,
  });
}
