// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  final int status;
  final SignUpData data;
  final String message;

  SignUpModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"],
        data: SignUpData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class SignUpData {
  final String id;
  final String name;
  final String password;
  final String mobileNumber;
  final String email;
  final String otp;
  final List<ChildData> children;
  final List<InterestData> interest;

  SignUpData({
    required this.id,
    required this.name,
    required this.password,
    required this.mobileNumber,
    required this.email,
    required this.otp,
    required this.children,
    required this.interest,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        otp: json["otp"],
        children: List<ChildData>.from(
            (json["children"] ?? []).map((x) => ChildData.fromJson(x))),
        interest: List<InterestData>.from(
            (json["interest"] ?? []).map((x) => InterestData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "mobile_number": mobileNumber,
        "email": email,
        "otp": otp,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "interest": List<dynamic>.from(interest.map((x) => x.toJson())),
      };
}

class ChildData {
  final String name;
  final String age;

  ChildData({
    required this.name,
    required this.age,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        name: json["name"] ?? "",
        age: json["age"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
      };

       Map<String, dynamic> toMap() {
    return <String, dynamic>{
        "name": name,
        "age": age,
    };
  }
}

class InterestData {
  final String id;
  final String name;

  InterestData({
    required this.id,
    required this.name,
  });

  factory InterestData.fromJson(Map<String, dynamic> json) => InterestData(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
