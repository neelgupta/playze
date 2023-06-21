class AboutModel {
  final int status;
  final CommonAppInfoData data;
  final String message;

  AboutModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
        status: json["status"] ?? 0,
        data: CommonAppInfoData.fromJson(json["data"] ?? {}),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class CommonAppInfoData {
  final String id;
  final String termsconditiontitle;
  final String termscondition;
  final String privacypolicytitle;
  final String privacypolicy;
  final String abouteas;

  CommonAppInfoData({
    required this.id,
    required this.termsconditiontitle,
    required this.termscondition,
    required this.privacypolicytitle,
    required this.privacypolicy,
    required this.abouteas,
  });

  factory CommonAppInfoData.fromJson(Map<String, dynamic> json) =>
      CommonAppInfoData(
        id: json["id"] ?? "",
        termsconditiontitle: json["terms_condition_title"] ?? "",
        termscondition: json["terms_condition"] ?? "",
        privacypolicytitle: json["privacy_policy_title"] ?? "",
        privacypolicy: json["privacy_policy"] ?? "",
        abouteas: json["aboute_as"] ?? "",
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
