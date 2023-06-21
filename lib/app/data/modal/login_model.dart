// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:playze/app/data/modal/signup_model.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final int status;
  final LoginUserData data;
  final String message;

  LoginModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] ?? 0,
        data: LoginUserData.fromJson(json["data"] ?? {}),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class LoginUserData {
  final String id;
  final String firstName;
  final String lastName;
  final String password;
  final String mobileNumber;
  final String email;
  final String token;
  final List<ChildData> children;

  LoginUserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.mobileNumber,
    required this.email,
    required this.token,
    required this.children,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
        id: json["id"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        password: json["password"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        email: json["email"] ?? "",
        token: json["token"] ?? "",
        children: List<ChildData>.from(
            (json["children"] ?? []).map((x) => ChildData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "mobile_number": mobileNumber,
        "email": email,
        "token": token,
        "children": children,
      };

  LoginUserData copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? password,
    String? mobileNumber,
    String? email,
    String? token,
    List<ChildData>? children,
  }) {
    return LoginUserData(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      token: token ?? this.token,
      children: children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'mobileNumber': mobileNumber,
      'email': email,
      'token': token,
      'children': children.map((x) => x.toMap()).toList(),
    };
  }

  factory LoginUserData.fromMap(Map<String, dynamic> map) {
    return LoginUserData(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      password: map['password'] as String,
      mobileNumber: map['mobileNumber'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
      children: map['children'] as List<ChildData>,
    );
  }
}

// class ChildData {
//   final String name;
//   final String age;

//   ChildData({
//     required this.name,
//     required this.age,
//   });

//   factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
//         name: json["name"] ?? "",
//         age: json["age"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "age": age,
//       };
// }
