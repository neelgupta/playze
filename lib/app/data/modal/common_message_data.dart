class CommonMessageData {
  CommonMessageData({
    required this.status,
    required this.message,
  });

  final int status;
  final String message;

  factory CommonMessageData.fromJson(Map<String, dynamic> json) =>
      CommonMessageData(
        status: json["status"] ?? 0,
        message: json["message"] ?? "",
      );
}
