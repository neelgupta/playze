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
  String? distance;
  String? duration;
  String? totalReview;
  String? rating;
  String? avgRating;
  List<Highlight>? highlights;
  List<ImageData>? images;
  List<VideoData>? video;

  PlaceDetails({
    this.id,
    this.placesName,
    this.address,
    this.latitude,
    this.longitude,
    this.costAdults,
    this.costChildren,
    this.logo,
    this.distance,
    this.duration,
    this.totalReview,
    this.rating,
    this.avgRating,
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
        distance: json["distance"],
        duration: json["duration"],
        totalReview: json["total_review"],
        rating: json["rating"],
        avgRating: json["avg_rating"],
        highlights: json["highlights"] == null
            ? []
            : List<Highlight>.from(
                json["highlights"]!.map((x) => Highlight.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<ImageData>.from(
                json["images"]!.map((x) => ImageData.fromJson(x))),
        video: json["video"] == null
            ? []
            : List<VideoData>.from(
                json["video"]!.map((x) => VideoData.fromJson(x))),
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
        "distance": distance,
        "duration": duration,
        "total_review": totalReview,
        "rating": rating,
        "avg_rating": avgRating,
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

class ImageData {
  String? id;
  String? images;

  ImageData({
    this.id,
    this.images,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": images,
      };
}

class VideoData {
  String? id;
  String? video;
  String? videoImage;

  VideoData({
    this.id,
    this.video,
    this.videoImage,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
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
