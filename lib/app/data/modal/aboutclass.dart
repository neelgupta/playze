class AboutModel {
  int? status;
  Data? data;
  String? message;

  AboutModel({
    this.status,
    this.data,
    this.message,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
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
  String? termsconditiontitle;
  String? termscondition;
  String? privacypolicytitle;
  String? privacypolicy;
  String? abouteas;

  Data({
    this.id,
    this.termsconditiontitle,
    this.termscondition,
    this.privacypolicytitle,
    this.privacypolicy,
    this.abouteas,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    termsconditiontitle: json["terms_condition_title"],
    termscondition: json["terms_condition"],
    privacypolicytitle: json["privacy_policy_title"],
    privacypolicy: json["privacy_policy"],
    abouteas: json["aboute_as"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "terms_condition_title": termsconditiontitle,
    "terms_condition": termscondition,
    "privacy_policy_title": privacypolicytitle,
    "privacy_policy": privacypolicy,
    "aboute_as": abouteas,
  };
}