// To parse this JSON data, do
//
//     final getCategoryFilterModel = getCategoryFilterModelFromJson(jsonString);

import 'dart:convert';

GetCategoryFilterModel getCategoryFilterModelFromJson(String str) =>
    GetCategoryFilterModel.fromJson(json.decode(str));

String getCategoryFilterModelToJson(GetCategoryFilterModel data) =>
    json.encode(data.toJson());

class GetCategoryFilterModel {
  int status;
  List<CategoryFilterData> data;
  String message;

  GetCategoryFilterModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GetCategoryFilterModel.fromJson(Map<String, dynamic> json) =>
      GetCategoryFilterModel(
        status: json["status"] ?? 0,
        data: List<CategoryFilterData>.from(
            (json["data"] ?? []).map((x) => CategoryFilterData.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class CategoryFilterData {
  String id;
  String name;
  String status;

  CategoryFilterData({
    required this.id,
    required this.name,
    required this.status,
  });

  factory CategoryFilterData.fromJson(Map<String, dynamic> json) =>
      CategoryFilterData(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}
