// To parse this JSON data, do
//
//     final placeData = placeDataFromJson(jsonString);

import 'dart:convert';

PlaceDataModel placeDataFromJson(String str) =>
    PlaceDataModel.fromJson(json.decode(str));

String placeDataToJson(PlaceDataModel data) => json.encode(data.toJson());

class PlaceDataModel {
  int? status;
  List<PlaceDetails>? data;
  String? message;

  PlaceDataModel({
    this.status,
    this.data,
    this.message,
  });

  factory PlaceDataModel.fromJson(Map<String, dynamic> json) => PlaceDataModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PlaceDetails>.from(
                json["data"]!.map((x) => PlaceDetails.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class PlaceDetails {
  String? id;
  String? placesName;
  String? address;
  String? latitude;
  String? longitude;
  String? costAdults;
  String? costChildren;
  String? logo;
  int? rating;
  int? totalreview;
  List<Highlight>? highlights;
  List<Image>? images;
  List<Video>? video;

  PlaceDetails({
    this.id,
    this.placesName,
    this.address,
    this.latitude,
    this.longitude,
    this.costAdults,
    this.costChildren,
    this.logo,
    this.totalreview,
    this.rating,
    this.highlights,
    this.images,
    this.video,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) => PlaceDetails(
        id: json["id"],
        placesName: json["places_name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        costAdults: json["cost_adults"],
        costChildren: json["cost_children"],
        logo: json["logo"],
        totalreview: json["total_review"],
        rating: json["rating"],
        highlights: json["highlights"] == null
            ? []
            : List<Highlight>.from(
                json["highlights"]!.map((x) => Highlight.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        video: json["video"] == null
            ? []
            : List<Video>.from(json["video"]!.map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "places_name": placesName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "cost_adults": costAdults,
        "cost_children": costChildren,
        "logo": logo,
        "total_review": totalreview,
        "rating": rating,
        "highlights": highlights == null
            ? []
            : List<dynamic>.from(highlights!.map((x) => x.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "video": video == null
            ? []
            : List<dynamic>.from(video!.map((x) => x.toJson())),
      };
}

class Highlight {
  String? id;
  String? highlights;

  Highlight({
    this.id,
    this.highlights,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        id: json["id"],
        highlights: json["highlights"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "highlights": highlights,
      };
}

class Image {
  String? id;
  String? images;

  Image({
    this.id,
    this.images,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": images,
      };
}

class Video {
  String? id;
  String? video;
  String? videoImage;

  Video({
    this.id,
    this.video,
    this.videoImage,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        video: json["video"],
        videoImage: json["video_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "video_image": videoImage,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
