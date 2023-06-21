import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:playze/reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/Network/network.dart';
import 'package:playze/app/data/modal/common_message_data.dart';
import 'package:playze/app/data/modal/get_emoji_model.dart';
import 'package:playze/app/data/modal/otp_model.dart';
import 'package:playze/app/data/modal/signup_model.dart';

import '../modal/filters_model.dart';
import '../modal/login_model.dart';
import 'api_url_list.dart';

class LoginService {
  Future<FiltersModel?> getInterestsMethod({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.getinterest;
    var result = await NetworkHandler().getwithoutToken(
      url,
      client,
    );
    log("getInterestsMethod result is $result");
    if (result != null) {
      var resbody = jsonDecode(result);
      if (resbody["status"] == 200) {
        return FiltersModel.fromjson(jsonDecode(result));
      } else {
        Fluttertoast.showToast(
          msg: resbody["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        throw Exception("Error getInterestsMethod list");
      }
    } else {
      throw Exception("Error getInterestsMethod list");
    }
  }

  Future<SignUpModel?> signUpMethod(
      name, lname, email, pnumbar, password, cpassword, cname, cage, interest,
      {client}) async {
    client ??= http.Client();
    log(ApiUrlList.register);
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
    log("signUpMethod result is $result");
    if (result != null) {
      var resbody = jsonDecode(result);
      if (resbody["status"] == 200) {
        return SignUpModel.fromJson(jsonDecode(result));
      } else {
        Fluttertoast.showToast(
          msg: resbody["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        throw Exception("Error getInterestsMethod list");
      }
    } else {
      return null;
      // throw Exception('Failed to load album');
    }
  }

  Future<LoginModel?> loginMethod(email, password, {client}) async {
    client ??= http.Client();
    log(ApiUrlList.login);
    var url = ApiUrlList.login;
    var result = await NetworkHandler().postwithoutToken(url, client, model: {
      "email": email,
      "password": password,
    });
    log("loginMethod result is $result");
    if (result != null) {
      var resbody = jsonDecode(result);
      if (resbody["status"] == 200) {
        return LoginModel.fromJson(jsonDecode(result));
      } else {
        Fluttertoast.showToast(
          msg: resbody["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        throw Exception("Error getInterestsMethod list");
      }
    } else {
      log("loginMethod failed");
      return null;
    }
  }

  Future<OtpModel?> sendOtpMethod(id, otp, {client}) async {
    client ??= http.Client();
    log(ApiUrlList.otp);
    var url = ApiUrlList.otp;
    var result = await NetworkHandler().postwithoutToken(url, client, model: {
      "users_id": id,
      "otp": otp,
    });
    log("sendOtpMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return OtpModel.fromJson(jsonDecode(result));
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } else {
      return null;
    }
  }

  Future<CommonMessageData?> resendOtpMethod(email, {client}) async {
    client ??= http.Client();
    log(ApiUrlList.resendOtp);
    var url = ApiUrlList.resendOtp;
    var result = await NetworkHandler().postwithoutToken(url, client, model: {
      "email": email,
    });
    log("resendOtpMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return CommonMessageData.fromJson(jsonDecode(result));
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } else {
      return null;
    }
  }

  Future<GetEmojiModel?> getActiveEmojisListMethod({client}) async {
    List<String>? tokan =
        SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    client ??= http.Client();
    var url = ApiUrlList.activeEmojisList;
    String newtokan = tokan![1];
    log("newtokan : $newtokan");
    var result = await NetworkHandler().get(url, client, newtokan);
    log("getActiveEmojisListMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return GetEmojiModel.fromJson(jsonDecode(result));
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } else {
      throw Exception("Error getActiveEmojisListMethod list");
    }
  }

  Future<bool?> forgotPasswordMethod({emailID, client}) async {
    List<String>? tokan =
        SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    client ??= http.Client();
    var url = ApiUrlList.forgotPassword;
    String newtokan = tokan![1];
    log("newtokan : $newtokan");
    var model = {
      "email": emailID,
    };
    var result = await NetworkHandler().postwithoutToken(
      url,
      client,
      model: model,
      // newtokan,
    );
    log("forgotPasswordMethod result is $result");
    if (result != null) {
      var resbody = jsonDecode(result);
      if (resbody["status"] == 200) {
        Fluttertoast.showToast(
          msg: resbody["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: resbody["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    } else {
      throw Exception("Error forgotPasswordMethod list");
    }
  }
}
