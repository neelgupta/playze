// To parse this JSON data, do
//
//     final signModel = signModelFromJson(jsonString);

import 'dart:convert';

SignModel signModelFromJson(String str) => SignModel.fromJson(json.decode(str));

String signModelToJson(SignModel data) => json.encode(data.toJson());

class SignModel {
  int status;
  Data data;
  String message;

  SignModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory SignModel.fromJson(Map<String, dynamic> json) => SignModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  String id;
  String firstName;
  String lastName;
  String password;
  String mobileNumber;
  String email;
  String otp;
  List<Child> children;
  List<Interest> interest;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.mobileNumber,
    required this.email,
    required this.otp,
    required this.children,
    required this.interest,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    password: json["password"],
    mobileNumber: json["mobile_number"],
    email: json["email"],
    otp: json["otp"],
    children: List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
    interest: List<Interest>.from(json["interest"].map((x) => Interest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "password": password,
    "mobile_number": mobileNumber,
    "email": email,
    "otp": otp,
    "children": List<dynamic>.from(children.map((x) => x.toJson())),
    "interest": List<dynamic>.from(interest.map((x) => x.toJson())),
  };
}

class Child {
  String name;
  String age;

  Child({
    required this.name,
    required this.age,
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
  String id;
  String name;

  Interest({
    required this.id,
    required this.name,
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
