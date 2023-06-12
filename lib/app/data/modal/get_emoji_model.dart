// To parse this JSON data, do
//
//     final getEmoji = getEmojiFromJson(jsonString);

import 'dart:convert';

GetEmojiModel getEmojiFromJson(String str) =>
    GetEmojiModel.fromJson(json.decode(str));

String getEmojiToJson(GetEmojiModel data) => json.encode(data.toJson());

class GetEmojiModel {
  final int status;
  final List<ActiveEmojiData> data;
  final String message;

  GetEmojiModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GetEmojiModel.fromJson(Map<String, dynamic> json) => GetEmojiModel(
        status: json["status"] ?? 0,
        data: json["data"] == null
            ? []
            : List<ActiveEmojiData>.from(
                json["data"]!.map((x) => ActiveEmojiData.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class ActiveEmojiData {
  String id;
  String title;
  List<EmojiData> emojis;

  ActiveEmojiData({
    required this.id,
    required this.title,
    required this.emojis,
  });

  factory ActiveEmojiData.fromJson(Map<String, dynamic> json) =>
      ActiveEmojiData(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        emojis: json["emojis"] == null
            ? []
            : List<EmojiData>.from(
                json["emojis"]!.map((x) => EmojiData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "emojis": List<dynamic>.from(emojis.map((x) => x.toJson())),
      };
}

class EmojiData {
  String id;
  String images;

  EmojiData({
    required this.id,
    required this.images,
  });

  factory EmojiData.fromJson(Map<String, dynamic> json) => EmojiData(
        id: json["id"] ?? "",
        images: json["images"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": images,
      };
}
