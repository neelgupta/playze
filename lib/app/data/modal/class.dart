class hp {
  int status;
  List<dp> data;
  String message;

  hp(this.status, this.data, this.message);

  factory hp.fromjson(Map<dynamic, dynamic> map) {
    List list = map['data'];
    List<dp> data = list.map((e) => dp.fromjson(e)).toList();
    return hp(map['status'], data, map['message']);
  }
}

class dp {
  String id;
  String name;
  String status;
  bool isSelected;

  dp(
    this.id,
    this.name,
    this.status, {
    this.isSelected = false,
  });

  factory dp.fromjson(Map<dynamic, dynamic> map) {
    return dp(
      map['id'],
      map['name'],
      map['status'],
    );
  }
}
