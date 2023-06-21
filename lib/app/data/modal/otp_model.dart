// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  final int status;
  final OtpData data;
  final String message;

  OtpModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        status: json["status"] ?? 0,
        data: OtpData.fromJson(json["data"] ?? {}),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class OtpData {
  String usersId;
  String otp;
  String token;

  OtpData({
    required this.usersId,
    required this.otp,
    required this.token,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
        usersId: json["users_id"] ?? "",
        otp: json["otp"] ?? "",
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "users_id": usersId,
        "otp": otp,
        "token": token,
      };
}
