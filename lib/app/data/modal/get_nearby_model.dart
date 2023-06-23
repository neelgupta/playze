// To parse this JSON data, do
//
//     final getNearByModel = getNearByModelFromJson(jsonString);

import 'dart:convert';

GetNearByModel getNearByModelFromJson(String str) =>
    GetNearByModel.fromJson(json.decode(str));

String getNearByModelToJson(GetNearByModel data) => json.encode(data.toJson());

class GetNearByModel {
  int status;
  List<NearByPlaceData> data;
  String message;

  GetNearByModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GetNearByModel.fromJson(Map<String, dynamic> json) => GetNearByModel(
        status: json["status"] ?? 0,
        data: List<NearByPlaceData>.from(
            (json["data"] ?? []).map((x) => NearByPlaceData.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class NearByPlaceData {
  String id;
  String placeImage;
  String placesName;
  String address;
  String totalReview;
  final bool isfavorite;
  String rating;
  String distance;
  String duration;

  NearByPlaceData({
    required this.id,
    required this.placeImage,
    required this.placesName,
    required this.address,
    required this.isfavorite,
    required this.totalReview,
    required this.rating,
    required this.distance,
    required this.duration,
  });

  factory NearByPlaceData.fromJson(Map<String, dynamic> json) =>
      NearByPlaceData(
        id: json["id"] ?? "",
        placeImage: json["place_image"] ?? "",
        placesName: json["places_name"] ?? "",
        address: json["address"] ?? "",
        totalReview: json["total_review"] ?? "",
        isfavorite: json["isfavorite "] ?? false,
        rating: json["rating"] ?? "",
        distance: json["distance"] ?? "",
        duration: json["duration"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_image": placeImage,
        "places_name": placesName,
        "address": address,
        "isfavorite ": isfavorite,
        "total_review": totalReview,
        "rating": rating,
        "distance": distance,
        "duration": duration,
      };
}
