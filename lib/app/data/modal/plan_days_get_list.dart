// To parse this JSON data, do
//
//     final planDaysGetList = planDaysGetListFromJson(jsonString);

import 'dart:convert';

PlanDaysGetList planDaysGetListFromJson(String str) =>
    PlanDaysGetList.fromJson(json.decode(str));

String planDaysGetListToJson(PlanDaysGetList data) =>
    json.encode(data.toJson());

class PlanDaysGetList {
  final int status;
  final List<DayDatum> data;
  final String message;

  PlanDaysGetList({
    required this.status,
    required this.data,
    required this.message,
  });

  factory PlanDaysGetList.fromJson(Map<String, dynamic> json) =>
      PlanDaysGetList(
        status: json["status"] ?? 0,
        data: List<DayDatum>.from(
            (json["data"] ?? []).map((x) => DayDatum.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DayDatum {
  final String id;
  final String day;
  final String dayNumber;

  DayDatum({
    required this.id,
    required this.day,
    required this.dayNumber,
  });

  factory DayDatum.fromJson(Map<String, dynamic> json) => DayDatum(
        id: json["id"] ?? "",
        day: json["day"] ?? "",
        dayNumber: json["day_number"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "day_number": dayNumber,
      };
}
