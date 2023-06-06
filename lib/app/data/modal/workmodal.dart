// To parse this JSON data, do
//
//     final workModal = workModalFromJson(jsonString);

import 'dart:convert';

WorkModal workModalFromJson(String str) => WorkModal.fromJson(json.decode(str));

String workModalToJson(WorkModal data) => json.encode(data.toJson());

class WorkModal {
  final int status;
  final List<WorkSData> data;
  final String message;

  WorkModal({
    required this.status,
    required this.data,
    required this.message,
  });

  factory WorkModal.fromJson(Map<String, dynamic> json) => WorkModal(
        status: json["status"] ?? "",
        data: List<WorkSData>.from(
            (json["data"] ?? []).map((x) => WorkSData.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class WorkSData {
  final String id;
  final String userId;
  final String placesName;
  final String address;
  final int latitude;
  final int longitude;
  final String image;
  final int rating;
  final int totalRating;

  WorkSData({
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

  factory WorkSData.fromJson(Map<String, dynamic> json) => WorkSData(
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
