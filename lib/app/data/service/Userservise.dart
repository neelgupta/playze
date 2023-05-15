import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playze/app/data/Network/network.dart';
import 'package:playze/app/data/modal/aboutclass.dart';
import 'package:playze/app/data/modal/class.dart';
import 'package:playze/app/data/modal/comman.dart';
import 'package:playze/app/data/modal/plaseModel.dart';
import 'package:playze/app/data/modal/userdata.dart';
import 'package:playze/app/data/service/Api_list.dart';

import '../../../Reusability/utils/shared_prefs.dart';
import '../modal/login.dart';

class Usersevise{

   List<String> ? tokan = SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");

  Future<Commonmsg?> postUserChengpassword(
      id, opassword,npassword,cpassword,{client}) async {
    client ??= http.Client();
    print(ApiURLList.UserChengpassword);
    String newtokan = tokan![1];
    print(newtokan);
    var url = ApiURLList.UserChengpassword;
    var result = await  NetworkHandler().post(url, client,newtokan,model: {
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

   Future<Commonmsg?> postcontactus(
       name, email,massage,{client}) async {
     client ??= http.Client();
     print(ApiURLList.Contactus);
     String newtokan = tokan![1];
     print(newtokan);
     var url = ApiURLList.Contactus;
     var result = await  NetworkHandler().post(url, client,newtokan,model: {
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

   Future<hp?> getCategorylist ({client}) async {
     if (client == null) {
       client = http.Client();
       // token = Util().getToken()!;
     }
     var url = ApiURLList.CategoryList;
     String newtokan = tokan![1];
     print(newtokan);
     var result = await NetworkHandler().get(url, client,newtokan);
     print("getinterest result is $result");
     if (result != null) {
       return hp.fromjson(jsonDecode(result));
     } else {
       throw Exception("Error getting agreement list");
     }
   }

   Future<AboutModel?> getAboutus ({client}) async {
     if (client == null) {
       client = http.Client();
       // token = Util().getToken()!;
     }
     var url = ApiURLList.Aboutus;
     String newtokan = tokan![1];
     print(newtokan);
     var result = await NetworkHandler().get(url, client,newtokan);
     print("getinterest result is $result");
     if (result != null) {
       return AboutModel.fromJson(jsonDecode(result));
     } else {
       throw Exception("Error getting agreement list");
     }
   }

   Future<DataModal?> getdata (id,{client}) async {
     if (client == null) {
       client = http.Client();
       // token = Util().getToken()!;
     }
     var url = ApiURLList.userDetailes;
     String newtokan = tokan![1];
     print(newtokan);
     var result = await NetworkHandler().post(url, client,newtokan,model: {"id" : id});
     print("getdata result is $result");
     if (result != null) {
       return DataModal.fromJson(jsonDecode(result));
     } else {
       throw Exception("Error getting agreement list");
     }
   }

   Future<Commonmsg?> getdeletechildren (id,{client}) async {
     if (client == null) {
       client = http.Client();
       // token = Util().getToken()!;
     }
     var url = ApiURLList.deleteChildren;
     String newtokan = tokan![1];
     print(newtokan);
     var result = await NetworkHandler().post(url, client,newtokan,model: {"id" : id});
     print("getdeletechildren result is $result");
     if (result != null) {
       return Commonmsg.fromJson(jsonDecode(result));
     } else {
       throw Exception("Error getting agreement list");
     }
   }

   Future<PlaseModel?> getPlasedata ({client}) async {
     if (client == null) {
       client = http.Client();
       // token = Util().getToken()!;
     }
     var url = ApiURLList.deleteChildren;
     String newtokan = tokan![1];
     print(newtokan);
     var result = await NetworkHandler().post(url, client,newtokan);
     print("getPlasedata result is $result");
     if (result != null) {
       return PlaseModel.fromJson(jsonDecode(result));
     } else {
       throw Exception("Error getting agreement list");
     }
   }

   // Future<Commonmsg?> postupdatedata (id,{client}) async {
   //   if (client == null) {
   //     client = http.Client();
   //     // token = Util().getToken()!;
   //   }
   //   var url = ApiURLList.userDetailes;
   //   String newtokan = tokan![1];
   //   print(newtokan);
   //   var result = await NetworkHandler().post(url, client,newtokan,model: {"id" : id});
   //   print("postupdatedata result is $result");
   //   if (result != null) {
   //     return Commonmsg.fromJson(jsonDecode(result));
   //   } else {
   //     throw Exception("Error getting agreement list");
   //   }
}

