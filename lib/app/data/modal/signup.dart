// To parse this JSON data, do
//
//     final signModel = signModelFromJson(jsonString);

import 'dart:convert';

SignModel signModelFromJson(String str) => SignModel.fromJson(json.decode(str));

String signModelToJson(SignModel data) => json.encode(data.toJson());

class SignModel {
  int? status;
  Data? data;
  String? message;

  SignModel({
    this.status,
    this.data,
    this.message,
  });

  factory SignModel.fromJson(Map<String, dynamic> json) => SignModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? id;
  String? name;
  String? password;
  String? mobileNumber;
  String? email;
  String? otp;
  List<Child>? children;
  List<Interest>? interest;

  Data({
    this.id,
    this.name,
    this.password,
    this.mobileNumber,
    this.email,
    this.otp,
    this.children,
    this.interest,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    password: json["password"],
    mobileNumber: json["mobile_number"],
    email: json["email"],
    otp: json["otp"],
    children: json["children"] == null ? [] : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
    interest: json["interest"] == null ? [] : List<Interest>.from(json["interest"]!.map((x) => Interest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "password": password,
    "mobile_number": mobileNumber,
    "email": email,
    "otp": otp,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    "interest": interest == null ? [] : List<dynamic>.from(interest!.map((x) => x.toJson())),
  };
}

class Child {
  String? name;
  String? age;

  Child({
    this.name,
    this.age,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    name: json["name"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
  };
}

class Interest {
  String? id;
  String? name;

  Interest({
    this.id,
    this.name,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
