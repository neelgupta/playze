class DataModal {
  DataModal({
    required this.status,
    required this.data,
    required this.message,
  });
  late final int status;
  late final Data data;
  late final String message;

  DataModal.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.password,
    required this.mobileNumber,
    required this.email,
    required this.image,
    required this.location,
    required this.children,
  });
  late final String id;
  late final String name;
  late final String password;
  late final String mobileNumber;
  late final String email;
  late final String image;
  late final String location;
  late final List<Children> children;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    password = json['password'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    image = json['images'];
    location = json['location'];
    children = List.from(json['children']).map((e)=>Children.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['password'] = password;
    _data['mobile_number'] = mobileNumber;
    _data['email'] = email;
    _data['images'] = image;
    _data['location'] = location;
    _data['children'] = children.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Children {
  Children({
    required this.id,
    required this.name,
    required this.age,
  });
  late final String id;
  late final String name;
  late final String age;

  Children.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['age'] = age;
    return _data;
  }
}