// To parse this JSON data, do
//
//     final getSearchFilterModel = getSearchFilterModelFromJson(jsonString);

import 'dart:convert';

GetSearchFilterModel getSearchFilterModelFromJson(String str) =>
    GetSearchFilterModel.fromJson(json.decode(str));

String getSearchFilterModelToJson(GetSearchFilterModel data) =>
    json.encode(data.toJson());

class GetSearchFilterModel {
  int status;
  SearchData data;
  String message;

  GetSearchFilterModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GetSearchFilterModel.fromJson(Map<String, dynamic> json) =>
      GetSearchFilterModel(
        status: json["status"] ?? 0,
        data: SearchData.fromJson(json["data"] ?? {}),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class SearchData {
  List<PlaceNameData> placeDetails;
  // List<Category> category;

  SearchData({
    required this.placeDetails,
    // required this.category,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        placeDetails: List<PlaceNameData>.from((json["place_details"] ?? [])
            .map((x) => PlaceNameData.fromJson(x))),
        // category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "place_details":
            List<dynamic>.from(placeDetails.map((x) => x.toJson())),
        // "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class PlaceNameData {
  String id;
  String placeName;

  PlaceNameData({
    required this.id,
    required this.placeName,
  });

  factory PlaceNameData.fromJson(Map<String, dynamic> json) => PlaceNameData(
        id: json["id"] ?? "",
        placeName: json["place_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_name": placeName,
      };
}

// class Category {
//     String category;

//     Category({
//         required this.category,
//     });

//     factory Category.fromJson(Map<String, dynamic> json) => Category(
//         category: json["category"],
//     );

//     Map<String, dynamic> toJson() => {
//         "category": category,
//     };
// }