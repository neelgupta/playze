import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/data/Network/network.dart';
import 'package:playze/app/data/modal/comman.dart';
import 'package:playze/app/data/modal/otp.dart';
import 'package:playze/app/data/modal/signup.dart';
import 'package:playze/app/data/service/Api_list.dart';

import '../modal/class.dart';
import '../modal/login.dart';


class loginService {


  Future<hp> getinterest({client}) async {
    if (client == null) {
      client = http.Client();
      // token = Util().getToken()!;
    }
    var url = ApiURLList.Getinterest;
    var result = await NetworkHandler().getwithoutToken(url, client,);
    print("getinterest result is $result");
    if (result != null) {
      return hp.fromjson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }

  Future<SignModel?> postsignup(name, lname, email, pnumbar, password,
      cpassword, cname, cage, interest, {client}) async {
    client ??= http.Client();
    print(ApiURLList.Register);
    var url = ApiURLList.Register;
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
    print(ApiURLList.login);
    var url = ApiURLList.login;
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
    print(ApiURLList.otp);
    var url = ApiURLList.otp;
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
    print(ApiURLList.Rotp);
    var url = ApiURLList.Rotp;
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

  // Future<Commonmsg?> postaddprofile(
  //     id, user_name,image,{client}) async {
  //   client ??= http.Client();
  //   print(ApiURLList.Addprofile);
  //   print(tokan);
  //   var url = ApiURLList.Addprofile;
  //   var result = await  NetworkHandler().post(url, client,tokan,model: {
  //     "user_id": id,
  //     "user_name": user_name,
  //     "image": image,
  //   });
  //   print("signup result is $result");
  //   if (result != null) {
  //     return Commonmsg.fromJson(jsonDecode(result));
  //   } else {
  //     return null;
  //   }
  // }

  // Future<Commonmsg?> postaddprofile(String?file, id, userid, {client}) async {
  //   var postUri = Uri.parse(ApiURLList.Addprofile);
  //   var request = http.MultipartRequest("POST", postUri);
  //   request.headers['Authorization'] =
  //   "Bearer ${(tokan!.substring(3))}";
  //   http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
  //       'image', file!.pat);
  //   request.files.add(multipartFile);
  //
  //   http.StreamedResponse response = await request.send();
  //   print('code: ${response.statusCode}');
  //   final res = await http.Response.fromStream(response);
  //   print('body: ${res.body}');
  // }
    // Future<Commonmsg?> postaddprofile(filePath,id,userid) async {
    //   var postUri = Uri.parse(ApiURLList.Addprofile);
    //
    //   http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    //
    //   http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
    //           'image', filePath);
    //   request.fields['user_id'] = id;
    //   request.fields['user_name'] = userid;
    //   request.files.add(multipartFile);
    //   request.headers['Authorization'] ='bearer ${tokan!.substring(3)}';
    //   http.StreamedResponse response = await request.send();
    //   print(response);
    //   print(response.statusCode);
    // }
    // Future<Commonmsg?> postaddprofile(
    //     id,
    //     user_name,
    //     List<int>? imageData,
    //     String? fileType,
    //     {client}) async {
    //   client ??= http.Client();
    //   print(ApiURLList.Addprofile);
    //   print(tokan?.substring(3));
    //   var url = ApiURLList.Addprofile;
    //   var result = await  NetworkHandler().postMutiPartData(url, client, tokan?.substring(3),
    //       fileName: 'profile_image.$fileType',
    //       fileType: fileType ?? '',
    //       file: imageData!,
    //       httpType: "POST",
    //       model: {
    //     "user_id":id,
    //     "user_name":user_name
    //   });
    //   print("signup result is $result");
    //   if (result != null) {
    //     return Commonmsg.fromJson(jsonDecode(result));
    //   } else {
    //     return null;
    //   }
    // }

  }