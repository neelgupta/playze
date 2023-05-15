// To parse this JSON data, do
//
//     final plaseModel = plaseModelFromJson(jsonString);

import 'dart:convert';

PlaseModel plaseModelFromJson(String str) => PlaseModel.fromJson(json.decode(str));

String plaseModelToJson(PlaseModel data) => json.encode(data.toJson());

class PlaseModel {
  int? status;
  List<Datum>? data;
  String? message;

  PlaseModel({
    this.status,
    this.data,
    this.message,
  });

  factory PlaseModel.fromJson(Map<String, dynamic> json) => PlaseModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  String? id;
  String? placesName;
  Address? address;
  String? latitude;
  String? longitude;
  String? costAdults;
  String? costChildren;
  List<Highlight>? highlights;
  List<Image>? images;
  List<Video>? video;

  Datum({
    this.id,
    this.placesName,
    this.address,
    this.latitude,
    this.longitude,
    this.costAdults,
    this.costChildren,
    this.highlights,
    this.images,
    this.video,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    placesName: json["places_name"],
    address: addressValues.map[json["address"]]!,
    latitude: json["latitude"],
    longitude: json["longitude"],
    costAdults: json["cost_adults"],
    costChildren: json["cost_children"],
    highlights: json["highlights"] == null ? [] : List<Highlight>.from(json["highlights"]!.map((x) => Highlight.fromJson(x))),
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    video: json["video"] == null ? [] : List<Video>.from(json["video"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "places_name": placesName,
    "address": addressValues.reverse[address],
    "latitude": latitude,
    "longitude": longitude,
    "cost_adults": costAdults,
    "cost_children": costChildren,
    "highlights": highlights == null ? [] : List<dynamic>.from(highlights!.map((x) => x.toJson())),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x.toJson())),
  };
}

enum Address { ASDFASDF }

final addressValues = EnumValues({
  "asdfasdf": Address.ASDFASDF
});

class Highlight {
  String? id;
  Highlights? highlights;

  Highlight({
    this.id,
    this.highlights,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
    id: json["id"],
    highlights: highlightsValues.map[json["highlights"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "highlights": highlightsValues.reverse[highlights],
  };
}

enum Highlights { SADFSGSWG, ASFSDGFSDG }

final highlightsValues = EnumValues({
  "asfsdgfsdg": Highlights.ASFSDGFSDG,
  "sadfsgswg": Highlights.SADFSGSWG
});

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

  Video({
    this.id,
    this.video,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "video": video,
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
