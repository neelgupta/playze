// To parse this JSON data, do
//
//     final planGetList = planGetListFromJson(jsonString);

import 'dart:convert';

PlanGetList planGetListFromJson(String str) =>
    PlanGetList.fromJson(json.decode(str));

String planGetListToJson(PlanGetList data) => json.encode(data.toJson());

class PlanGetList {
  final int status;
  final List<PlanData> data;
  final String message;

  PlanGetList({
    required this.status,
    required this.data,
    required this.message,
  });

  factory PlanGetList.fromJson(Map<String, dynamic> json) => PlanGetList(
        status: json["status"] ?? 0,
        data: List<PlanData>.from(
            (json["data"] ?? []).map((x) => PlanData.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PlanData {
  final String id;
  final String placeImage;
  final String startTime;
  final String planNumber;
  final String placeName;
  final String placeDescription;
  final String time;
  final String changeDuration;
  final String duration;

  PlanData({
    required this.id,
    required this.placeImage,
    required this.startTime,
    required this.planNumber,
    required this.placeName,
    required this.placeDescription,
    required this.time,
    required this.changeDuration,
    required this.duration,
  });

  factory PlanData.fromJson(Map<String, dynamic> json) => PlanData(
        id: json["id"] ?? "",
        placeImage: json["place_image"] ?? "",
        startTime: json["start_time"] ?? "",
        planNumber: json["plan_number"] ?? "",
        placeName: json["place_name"] ?? "",
        placeDescription: json["place_description"] ?? "",
        time: json["time"] ?? "",
        changeDuration: json["change_duration"] ?? "",
        duration: json["duration"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_image": placeImage,
        "start_time": startTime,
        "plan_number": planNumber,
        "place_name": placeName,
        "place_description": placeDescription,
        "time": time,
        "change_duration": changeDuration,
        "duration": duration,
      };
}
