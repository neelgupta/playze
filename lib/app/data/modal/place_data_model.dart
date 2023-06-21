import 'dart:convert';

PlaceDataModel placeDataFromJson(String str) =>
    PlaceDataModel.fromJson(json.decode(str));

String placeDataToJson(PlaceDataModel data) => json.encode(data.toJson());

class PlaceDataModel {
  final int status;
  final List<PlaceDetails> data;
  final String message;

  PlaceDataModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory PlaceDataModel.fromJson(Map<String, dynamic> json) => PlaceDataModel(
        status: json["status"] ?? 0,
        data: List<PlaceDetails>.from(
            (json["data"] ?? []).map((x) => PlaceDetails.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PlaceDetails {
  final String id;
  final String placesName;
  final String address;
  final String latitude;
  final String longitude;
  final String costAdults;
  final String costChildren;
  final String logo;
  final String distance;
  final String duration;
  final String totalReview;
  final String rating;
  final String avgRating;
  final List<HighlightData> highlights;
  final List<ImageData> images;
  final List<VideoData> video;

  PlaceDetails({
    required this.id,
    required this.placesName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.costAdults,
    required this.costChildren,
    required this.logo,
    required this.distance,
    required this.duration,
    required this.totalReview,
    required this.rating,
    required this.avgRating,
    required this.highlights,
    required this.images,
    required this.video,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) => PlaceDetails(
        id: json["id"] ?? "",
        placesName: json["places_name"] ?? "",
        address: json["address"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        costAdults: json["cost_adults"] ?? "",
        costChildren: json["cost_children"] ?? "",
        logo: json["logo"] ?? "",
        distance: json["distance"] ?? "",
        duration: json["duration"] ?? "",
        totalReview: json["total_review"] ?? "",
        rating: json["rating"] ?? "",
        avgRating: json["avg_rating"] ?? "",
        highlights: List<HighlightData>.from(
            (json["highlights"] ?? []).map((x) => HighlightData.fromJson(x))),
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
        "logo": logo,
        "distance": distance,
        "duration": duration,
        "total_review": totalReview,
        "rating": rating,
        "avg_rating": avgRating,
        "highlights": List<dynamic>.from(highlights.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "video": List<dynamic>.from(video.map((x) => x.toJson())),
      };
}

class HighlightData {
  final String id;
  final String highlights;

  HighlightData({
    required this.id,
    required this.highlights,
  });

  factory HighlightData.fromJson(Map<String, dynamic> json) => HighlightData(
        id: json["id"] ?? "",
        highlights: json["highlights"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "highlights": highlights,
      };
}

class ImageData {
  final String id;
  final String images;

  ImageData({
    required this.id,
    required this.images,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"] ?? "",
        images: json["images"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": images,
      };
}

class VideoData {
  final String id;
  final String video;
  final String videoImage;

  VideoData({
    required this.id,
    required this.video,
    required this.videoImage,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        id: json["id"] ?? "",
        video: json["video"] ?? "",
        videoImage: json["video_image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "video_image": videoImage,
      };
}
