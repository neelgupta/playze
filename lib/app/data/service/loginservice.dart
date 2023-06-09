import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/Network/network.dart';
import 'package:playze/app/data/modal/comman.dart';
import 'package:playze/app/data/modal/emoji.dart';
import 'package:playze/app/data/modal/otp.dart';
import 'package:playze/app/data/modal/signup.dart';
import 'package:playze/app/data/service/api_list.dart';

import '../modal/class.dart';
import '../modal/login.dart';

class loginService {
  Future<hp> getinterest({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.getinterest;
    var result = await NetworkHandler().getwithoutToken(
      url,
      client,
    );
    print("getinterest result is $result");
    if (result != null) {
      return hp.fromjson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<SignModel?> postsignup(
      name, lname, email, pnumbar, password, cpassword, cname, cage, interest,
      {client}) async {
    client ??= http.Client();
    print(ApiUrlList.register);
    var url = ApiUrlList.register;
    var result = await NetworkHandler().postwithoutToken(url, client, model: {
      "first_name": name,
      "last_name": lname,
      "email": email,
      "phone_number": pnumbar,
      "password": password,
      "password_confirmation": cpassword,
      "children_name": cname,
      "children_age": cage,
      "interest": interest,
    });
    print("signup result is $result");
    if (result != null) {
      return SignModel.fromJson(jsonDecode(result));
    } else {
      return null;
      throw Exception('Failed to load album');
    }
  }

  Future<LoginModel?> postlogin(email, password, {client}) async {
    client ??= http.Client();
    print(ApiUrlList.login);
    var url = ApiUrlList.login;
    var result = await NetworkHandler().postwithoutToken(url, client, model: {
      "email": email,
      "password": password,
    });
    print("signup result is $result");
    if (result != null) {
      print("oo");
      return LoginModel.fromJson(jsonDecode(result));
    } else {
      print("111");
      return null;
    }
  }

  Future<OtpModel?> postotp(id, otp, {client}) async {
    client ??= http.Client();
    print(ApiUrlList.otp);
    var url = ApiUrlList.otp;
    var result = await NetworkHandler().postwithoutToken(url, client, model: {
      "users_id": id,
      "otp": otp,
    });
    print("signup result is $result");
    if (result != null) {
      return OtpModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<Commonmsg?> postRotp(email, {client}) async {
    client ??= http.Client();
    print(ApiUrlList.resendOtp);
    var url = ApiUrlList.resendOtp;
    var result = await NetworkHandler().postwithoutToken(url, client, model: {
      "email": email,
    });
    print("signup result is $result");
    if (result != null) {
      return Commonmsg.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<GetEmoji?> getemoji({client}) async {
    List<String>? tokan =
        SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    client ??= http.Client();
    var url = ApiUrlList.activeEmojisList;
    String newtokan = tokan![1];
    print(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    print("getPlasedata result is $result");
    if (result != null) {
      return GetEmoji.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }
}
