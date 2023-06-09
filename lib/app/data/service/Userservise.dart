import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:playze/app/data/Network/network.dart';
import 'package:playze/app/data/modal/aboutclass.dart';
import 'package:playze/app/data/modal/class.dart';
import 'package:playze/app/data/modal/comman.dart';
import 'package:playze/app/data/modal/placeclass.dart';
import 'package:playze/app/data/modal/plaseModel.dart';
import 'package:playze/app/data/modal/userdata.dart';
import 'package:playze/app/data/modal/workmodal.dart';
import 'package:playze/app/data/service/api_list.dart';

import '../../../Reusability/utils/shared_prefs.dart';

class Usersevise {
  List<String>? tokan =
      SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");

  Future<Commonmsg?> postUserChengpassword(id, opassword, npassword, cpassword,
      {client}) async {
    client ??= http.Client();
    print(ApiUrlList.userChangePassword);
    String newtokan = tokan![1];
    print(newtokan);
    var url = ApiUrlList.userChangePassword;
    var result = await NetworkHandler().post(url, client, newtokan, model: {
      "id": id,
      "old_password": opassword,
      "new_password": npassword,
      "password_confirmation": cpassword,
    });
    print("signup result is $result");
    if (result != null) {
      return Commonmsg.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<Commonmsg?> postcontactus(name, email, massage, {client}) async {
    client ??= http.Client();
    print(ApiUrlList.contactUs);
    String newtokan = tokan![1];
    print(newtokan);
    var url = ApiUrlList.contactUs;
    var result = await NetworkHandler().post(url, client, newtokan, model: {
      "name": name,
      "email": email,
      "message": massage,
    });
    print("signup result is $result");
    if (result != null) {
      return Commonmsg.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<hp?> getCategorylist({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.categoryList;
    String newtokan = tokan![1];
    print(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    print("getinterest result is $result");
    if (result != null) {
      return hp.fromjson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<AboutModel?> getAboutus({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.aboutus;
    String newtokan = tokan![1];
    print(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    print("getinterest result is $result");
    if (result != null) {
      return AboutModel.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<DataModal?> getdata(id, {client}) async {
    client ??= http.Client();
    var url = ApiUrlList.userDetailes;
    String newtokan = tokan![1];
    log("id : $id");
    log(newtokan);
    var result =
        await NetworkHandler().post(url, client, newtokan, model: {"id": id});
    log("getdata result is $result");
    if (result != null) {
      return DataModal.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<Commonmsg?> deletechildren(id, {client}) async {
    client ??= http.Client();
    var url = ApiUrlList.deleteChildren;
    String newtokan = tokan![1];
    print(newtokan);
    var result =
        await NetworkHandler().post(url, client, newtokan, model: {"id": id});
    print("getdeletechildren result is $result");
    if (result != null) {
      return Commonmsg.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<PlaceDataModel?> getPlasedata({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.placesActiveList;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    log("getPlasedata result is : $result");
    if (result != null) {
      return PlaceDataModel.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<WorkSpaceDetailModel?> postdataplace(id, {client}) async {
    client ??= http.Client();
    var url = ApiUrlList.plaseDetails;
    String newtokan = tokan![1];
    log(newtokan);
    var result =
        await NetworkHandler().post(url, client, newtokan, model: {"id": id});
    log("postdataplace result is $result");
    if (result != null) {
      return WorkSpaceDetailModel.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<WorkModal?> getwork({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.getWorkspace;
    String newtokan = tokan![1];
    print(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    print("getwork result is $result");
    if (result != null) {
      return WorkModal.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<bool?> addWorkSpaceToMyWorkSpace(
      {userId, placesId, status, client}) async {
    client ??= http.Client();
    var url = ApiUrlList.addWorkSpace;
    String newtokan = tokan![1];

    var reqBody = {
      "user_id": userId,
      "places_id": placesId,
      "status": status,
    };
    log("addWorkSpaceToMyWorkSpace token :: $newtokan");
    log("addWorkSpaceToMyWorkSpace reqBody :: $reqBody");
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: reqBody,
    );
    log("addWorkSpaceToMyWorkSpace result is :: $result");
    if (result != null) {
      return true;
    } else {
      // throw Exception("Error adding workspace");
      return false;
    }
  }
}
