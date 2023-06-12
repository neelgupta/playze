// To parse this JSON data, do
//
//     final getReviewsModel = getReviewsModelFromJson(jsonString);

import 'dart:convert';

GetReviewsModel getReviewsModelFromJson(String str) =>
    GetReviewsModel.fromJson(json.decode(str));

String getReviewsModelToJson(GetReviewsModel data) =>
    json.encode(data.toJson());

class GetReviewsModel {
  int status;
  RData? data;
  String message;

  GetReviewsModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GetReviewsModel.fromJson(Map<String, dynamic> json) =>
      GetReviewsModel(
        status: json["status"] ?? 0,
        data: json["data"] == "" ? null : RData.fromJson(json["data"] ?? {}),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
      };
}

class RData {
  List<ReviewData> review;
  List<VideoData> reviewVideo;
  List<ReviewFile> reviewFile;

  RData({
    required this.review,
    required this.reviewVideo,
    required this.reviewFile,
  });

  factory RData.fromJson(Map<String, dynamic> json) => RData(
        review: List<ReviewData>.from(
            (json["review"] ?? []).map((x) => ReviewData.fromJson(x))),
        reviewVideo: List<VideoData>.from(
            (json["review_video"] ?? []).map((x) => VideoData.fromJson(x))),
        reviewFile: List<ReviewFile>.from(
            (json["review_file"] ?? []).map((x) => ReviewFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "review": List<dynamic>.from(review.map((x) => x.toJson())),
        "review_video": List<dynamic>.from(reviewVideo.map((x) => x.toJson())),
        "review_file": List<dynamic>.from(reviewFile.map((x) => x.toJson())),
      };
}

class ReviewData {
  String id;
  String placesId;
  String profileImage;
  String userNameReviewDate;
  String rating;
  String review;
  List<VideoData> video;
  List<FileElement> files;

  ReviewData({
    required this.id,
    required this.placesId,
    required this.profileImage,
    required this.userNameReviewDate,
    required this.rating,
    required this.review,
    required this.video,
    required this.files,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        id: json["id"] ?? "",
        placesId: json["places_id"] ?? "",
        profileImage: json["profile_image"] ?? "",
        userNameReviewDate: json["user_name_review_date"] ?? "",
        rating: json["rating"] ?? "",
        review: json["review"] ?? "",
        video: json["video"] == null
            ? []
            : List<VideoData>.from(
                json["video"].map((x) => VideoData.fromJson(x))),
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "places_id": placesId,
        "profile_image": profileImage,
        "user_name_review_date": userNameReviewDate,
        "rating": rating,
        "review": review,
        "video": List<VideoData>.from(video.map((x) => x.toJson())),
        "files": List<FileElement>.from(files.map((x) => x.toJson())),
      };
}

class FileElement {
  String id;
  String files;

  FileElement({
    required this.id,
    required this.files,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"] ?? "",
        files: json["files"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "files": files,
      };
}

class VideoData {
  String id;
  String video;

  VideoData({
    required this.id,
    required this.video,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        id: json["id"] ?? "",
        video: json["video"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
      };
}

class ReviewFile {
  String id;
  String file;

  ReviewFile({
    required this.id,
    required this.file,
  });

  factory ReviewFile.fromJson(Map<String, dynamic> json) => ReviewFile(
        id: json["id"] ?? "",
        file: json["file"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
      };
}
