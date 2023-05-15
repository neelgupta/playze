class Commonmsg {
  Commonmsg(
      {
        this.status,
        this.message,
        });

  int? status;
  String? message;

  factory Commonmsg.fromJson(Map<String, dynamic> json) => Commonmsg(
    status: json["status"],
    message: json["message"],
  );
}