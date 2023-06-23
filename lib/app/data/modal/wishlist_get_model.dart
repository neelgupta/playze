// To parse this JSON data, do
//
//     final wishListGetModel = wishListGetModelFromJson(jsonString);

import 'dart:convert';

import 'package:playze/app/data/modal/place_data_model.dart';

WishListGetModel wishListGetModelFromJson(String str) =>
    WishListGetModel.fromJson(json.decode(str));

String wishListGetModelToJson(WishListGetModel data) =>
    json.encode(data.toJson());

class WishListGetModel {
  final int status;
  final List<WishListData> data;
  final String message;

  WishListGetModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory WishListGetModel.fromJson(Map<String, dynamic> json) =>
      WishListGetModel(
        status: json["status"] ?? 0,
        data: List<WishListData>.from(
            (json["data"] ?? []).map((x) => WishListData.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class WishListData {
  final String id;
  final String placesName;
  final String address;
  final String latitude;
  final String longitude;
  final String costAdults;
  final String costChildren;
  final String time;
  final bool isfavorite;
  final String logo;
  final String totalReview;
  final String rating;
  final List<ImageData> images;
  final List<VideoData> video;

  WishListData({
    required this.id,
    required this.placesName,
    required this.address,
    required this.latitude,
    required this.isfavorite,
    required this.longitude,
    required this.costAdults,
    required this.costChildren,
    required this.time,
    required this.logo,
    required this.totalReview,
    required this.rating,
    required this.images,
    required this.video,
  });

  factory WishListData.fromJson(Map<String, dynamic> json) => WishListData(
        id: json["id"] ?? "",
        placesName: json["places_name"] ?? "",
        address: json["address"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        costAdults: json["cost_adults"] ?? "",
        costChildren: json["cost_children"] ?? "",
        time: json["time"] ?? "",
        isfavorite: json["isfavorite"] ?? false,
        logo: json["logo"] ?? "",
        totalReview: json["total_review"] ?? "",
        rating: json["rating"] ?? "",
        images: List<ImageData>.from(
            (json["images"] ?? []).map((x) => ImageData.fromJson(x))),
        video: List<VideoData>.from(
            (json["video"] ?? []).map((x) => VideoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "places_name": placesName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "cost_adults": costAdults,
        "cost_children": costChildren,
        "time": time,
        "logo": logo,
        "isfavorite": isfavorite,
        "total_review": totalReview,
        "rating": rating,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "video": List<dynamic>.from(video.map((x) => x.toJson())),
      };
}
