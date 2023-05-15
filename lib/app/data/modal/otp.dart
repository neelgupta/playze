// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  int status;
  Data data;
  String message;

  OtpModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    status: json["status"],
    data: Data.fromJson(json["data"] ?? {}),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  String usersId;
  String otp;
  String token;

  Data({
    required this.usersId,
    required this.otp,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    usersId: json["users_id"],
    otp: json["otp"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "users_id": usersId,
    "otp": otp,
    "token": token,
  };
}
