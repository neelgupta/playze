// To parse this JSON data, do
//
//     final workSpaceModel = workSpaceModelFromJson(jsonString);

import 'dart:convert';

WorkSpaceListModel workSpaceListModelFromJson(String str) =>
    WorkSpaceListModel.fromJson(json.decode(str));

String workSpaceListModelToJson(WorkSpaceListModel data) =>
    json.encode(data.toJson());

class WorkSpaceListModel {
  final int status;
  final List<WorkSpaceData> data;
  final String message;

  WorkSpaceListModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory WorkSpaceListModel.fromJson(Map<String, dynamic> json) =>
      WorkSpaceListModel(
        status: json["status"] ?? 0,
        data: List<WorkSpaceData>.from(
          (json["data"] ?? []).map((x) => WorkSpaceData.fromJson(x)),
        ),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class WorkSpaceData {
  final String id;
  final String userId;
  final String placesName;
  final String address;
  final int latitude;
  final int longitude;
  final String image;
  final int rating;
  final int totalRating;

  WorkSpaceData({
    required this.id,
    required this.userId,
    required this.placesName,
    required this.address,
    required this.latitude,
    required this.image,
    required this.longitude,
    required this.rating,
    required this.totalRating,
  });

  factory WorkSpaceData.fromJson(Map<String, dynamic> json) => WorkSpaceData(
        id: json["id"] ?? "",
        userId: json["user_id"] ?? "",
        placesName: json["places_name"] ?? "",
        address: json["address"] ?? "",
        image: json["image"] ?? "",
        latitude: json["latitude"] ?? 0,
        longitude: json["longitude"] ?? 0,
        rating: json["rating"] ?? 0,
        totalRating: json["total_rating"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "places_name": placesName,
        "address": address,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
        "rating": rating,
        "total_rating": totalRating,
      };
}
