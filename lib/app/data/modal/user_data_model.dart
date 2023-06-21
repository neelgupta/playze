// To parse this JSON data, do
//
//     final UserdataModal = UserdataModalFromJson(jsonString);

import 'dart:convert';

import 'package:playze/app/data/modal/signup_model.dart';

UserDataModal userDataModalFromJson(String str) =>
    UserDataModal.fromJson(json.decode(str));

String userDataModalToJson(UserDataModal data) => json.encode(data.toJson());

class UserDataModal {
  final int status;
  final UserData data;
  final String message;

  UserDataModal({
    required this.status,
    required this.data,
    required this.message,
  });

  factory UserDataModal.fromJson(Map<String, dynamic> json) => UserDataModal(
        status: json["status"] ?? 0,
        data: UserData.fromJson(json["data"] ?? {}),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class UserData {
  final String id;
  final String name;
  final String password;
  final String mobileNumber;
  final String email;
  final String images;
  final String location;
  final List<ChildrenDetails> children;
  final List<InterestData> interest;

  UserData({
    required this.id,
    required this.name,
    required this.password,
    required this.mobileNumber,
    required this.email,
    required this.images,
    required this.location,
    required this.children,
    required this.interest,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        password: json["password"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        email: json["email"] ?? "",
        images: json["images"] ?? "",
        location: json["location"] ?? "",
        children: List<ChildrenDetails>.from(
            (json["children"] ?? []).map((x) => ChildrenDetails.fromJson(x))),
        interest: List<InterestData>.from(
            (json["interest"] ?? []).map((x) => InterestData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "mobile_number": mobileNumber,
        "email": email,
        "images": images,
        "location": location,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "interest": List<dynamic>.from(interest.map((x) => x.toJson())),
      };
}

class ChildrenDetails {
  final String id;
  final String name;
  final String age;

  ChildrenDetails({
    required this.id,
    required this.name,
    required this.age,
  });

  factory ChildrenDetails.fromJson(Map<String, dynamic> json) =>
      ChildrenDetails(
        id: json["id"] ?? "",
        name: json["name"] ?? '',
        age: json["age"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
      };
}

// class InterestDetails {
//   final String id;
//   final String name;

//   InterestDetails({
//     required this.id,
//     required this.name,
//   });

//   factory InterestDetails.fromJson(Map<String, dynamic> json) =>
//       InterestDetails(
//         id: json["id"] ?? "",
//         name: json["name"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
