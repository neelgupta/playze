// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';


LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? status;
  Data? data;
  String? message;

  LoginModel({
     this.status,
    this.data,
     this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    data: Data.fromJson(json["data"] ?? {}),
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
  String? firstName;
  String? lastName;
  String? password;
  String? mobileNumber;
  String? email;
  String? token;
  List<Child>? children;

  Data({
     this.id,
     this.firstName,
     this.lastName,
     this.password,
     this.mobileNumber,
     this.email,
     this.token,
     this.children,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    password: json["password"],
    mobileNumber: json["mobile_number"],
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "password": password,
    "mobile_number": mobileNumber,
    "email": email,
    "token": token,
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