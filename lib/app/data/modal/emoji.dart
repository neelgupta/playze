// To parse this JSON data, do
//
//     final getEmoji = getEmojiFromJson(jsonString);

import 'dart:convert';

GetEmoji getEmojiFromJson(String str) => GetEmoji.fromJson(json.decode(str));

String getEmojiToJson(GetEmoji data) => json.encode(data.toJson());

class GetEmoji {
  int? status;
  List<Datum>? data;
  String? message;

  GetEmoji({
    this.status,
    this.data,
    this.message,
  });

  factory GetEmoji.fromJson(Map<String, dynamic> json) => GetEmoji(
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
  String? title;
  List<Emoji>? emojis;

  Datum({
    this.id,
    this.title,
    this.emojis,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    emojis: json["emojis"] == null ? [] : List<Emoji>.from(json["emojis"]!.map((x) => Emoji.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "emojis": emojis == null ? [] : List<dynamic>.from(emojis!.map((x) => x.toJson())),
  };
}

class Emoji {
  String? id;
  String? images;

  Emoji({
    this.id,
    this.images,
  });

  factory Emoji.fromJson(Map<String, dynamic> json) => Emoji(
    id: json["id"],
    images: json["images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "images": images,
  };
}
