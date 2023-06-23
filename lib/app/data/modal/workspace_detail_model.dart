// To parse this JSON data, do
//
//     final workSpaceDetailModel = workSpaceDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:playze/app/data/modal/place_data_model.dart';

WorkSpaceDetailModel workSpaceDetailModelFromJson(String str) =>
    WorkSpaceDetailModel.fromJson(json.decode(str));

String workSpaceDetailModelToJson(WorkSpaceDetailModel data) =>
    json.encode(data.toJson());

class WorkSpaceDetailModel {
  final int status;
  final WorkSpaceData data;
  final String message;

  WorkSpaceDetailModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory WorkSpaceDetailModel.fromJson(Map<String, dynamic> json) =>
      WorkSpaceDetailModel(
        status: json["status"] ?? 0,
        data: WorkSpaceData.fromJson(json["data"] ?? {}),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class WorkSpaceData {
  final String id;
  final String placesName;
  final String address;
  final String latitude;
  final String longitude;
  final String description;
  final String costAdults;
  final String costChildren;
  final String location;
  final String contactNo;
  final String time;
  final bool isfavorite;
  final int totalRating;
  final int totalRatingOne;
  final int totalRatingTwo;
  final int totalRatingThree;
  final int totalRatingFour;
  final int totalRatingFive;
  final String avgRating;
  final List<HighlightData> highlights;
  final List<Image> images;
  final List<Video> video;

  WorkSpaceData({
    required this.id,
    required this.placesName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.costAdults,
    required this.costChildren,
    required this.location,
    required this.contactNo,
    required this.time,
    required this.isfavorite,
    required this.totalRating,
    required this.totalRatingOne,
    required this.totalRatingTwo,
    required this.totalRatingThree,
    required this.totalRatingFour,
    required this.totalRatingFive,
    required this.avgRating,
    required this.highlights,
    required this.images,
    required this.video,
  });

  factory WorkSpaceData.fromJson(Map<String, dynamic> json) => WorkSpaceData(
        id: json["id"] ?? "",
        placesName: json["places_name"] ?? "",
        address: json["address"] ?? "",
        latitude: json["latitude"] ?? 0,
        longitude: json["longitude"] ?? 0,
        description: json["description"] ?? "",
        costAdults: json["cost_adults"] ?? "",
        costChildren: json["cost_children"] ?? "",
        location: json["location"] ?? "",
        contactNo: json["contact_no"] ?? "",
        time: json["time"] ?? "",
        isfavorite: json["isfavorite "] ?? false,
        totalRating: json["total_rating"] ?? 0,
        totalRatingOne: json["total_rating_one"] ?? 0,
        totalRatingTwo: json["total_rating_two"] ?? 0,
        totalRatingThree: json["total_rating_three"] ?? 0,
        totalRatingFour: json["total_rating_four"] ?? 0,
        totalRatingFive: json["total_rating_five"] ?? 0,
        avgRating: (json["avg_rating"] ?? 0).toString(),
        highlights: List<HighlightData>.from(
            (json["highlights"] ?? []).map((x) => HighlightData.fromJson(x))),
        images: List<Image>.from(
            (json["images"] ?? []).map((x) => Image.fromJson(x))),
        video: List<Video>.from(
            (json["video"] ?? []).map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "places_name": placesName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "description": description,
        "cost_adults": costAdults,
        "cost_children": costChildren,
        "location": location,
        "contact_no": contactNo,
        "time": time,
        "isfavorite ": isfavorite,
        "total_rating": totalRating,
        "total_rating_one": totalRatingOne,
        "total_rating_two": totalRatingTwo,
        "total_rating_three": totalRatingThree,
        "total_rating_four": totalRatingFour,
        "total_rating_five": totalRatingFive,
        "avg_rating": avgRating,
        "highlights":
            List<HighlightData>.from(highlights.map((x) => x.toJson())),
        "images": List<Image>.from(images.map((x) => x.toJson())),
        "video": List<Video>.from(video.map((x) => x.toJson())),
      };
}

// class Highlight {
//   final String id;
//   final String highlights;

//   Highlight({
//     required this.id,
//     required this.highlights,
//   });

//   factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
//         id: json["id"] ?? "",
//         highlights: json["highlights"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "highlights": highlights,
//       };
// }

class Image {
  final String id;
  final String images;
  final String imagesTitle;

  Image({
    required this.id,
    required this.images,
    required this.imagesTitle,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"] ?? "",
        images: json["images"] ?? "",
        imagesTitle: json["images_title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": images,
        "images_title": imagesTitle,
      };
}

class Video {
  final String id;
  final String video;
  final String videoTitle;
  final String videoImage;

  Video({
    required this.id,
    required this.video,
    required this.videoTitle,
    required this.videoImage,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"] ?? "",
        video: json["video"] ?? "",
        videoTitle: json["video_title"] ?? "",
        videoImage: json["video_image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "video_title": videoTitle,
        "video_image": videoImage,
      };
}
