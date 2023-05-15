import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/data/modal/comman.dart';
import 'package:playze/app/data/service/loginservice.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationController extends GetxController {
  //TODO: Implement VerificationController

  final count = 0.obs;
  TextEditingController otpController = TextEditingController();
  loginService Loginervice = loginService();
  var argumentData = Get.arguments;
  RxBool isLoading = false.obs;
  String? usersId;
  String? email;
  String? phonenumbar;
  String? formattedPhoneNumber;

  @override
  void onInit() {
    super.onInit();
    usersId = SharedPrefs().value.read(SharedPrefs.userIdKey);
    email = SharedPrefs().value.read(SharedPrefs.emailKey);
    phonenumbar = SharedPrefs().value.read(SharedPrefs.mnumbarKey);
    print("usersId:+>$usersId");
    print("usersId:+>$email");
    print("usersId:+>$phonenumbar");
    formattedPhoneNumber = phonenumbar?.replaceFirst("(\d{3})(\d{3})(\d+)", "\$1) \$2-\$3");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

   Future<void> otp() async {
     isLoading(true);
     try{
       var sigin = await Loginervice.postotp(argumentData[0], otpController.text.trim());
       if (sigin?.status == 200) {
         Fluttertoast.showToast(
             msg: '${sigin?.message}',
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.blue,
             textColor: Colors.white,
             fontSize: 16.0);
         SharedPrefs().value.write(SharedPrefs.tokenKey, sigin?.data.token);
         SharedPrefs().value.write(SharedPrefs.userIdKey, sigin?.data.usersId);
         SharedPrefs().value.write(SharedPrefs.setBool, true);
         print("====>${(SharedPrefs().value.read(SharedPrefs.tokenKey))}");
         print("====>${(SharedPrefs().value.read(SharedPrefs.userIdKey))}");
         isLoading(false);
         Get.offNamedUntil(
           Routes.ADD_PROFILE_PICTURE,
               (route) => false,
         );
       } else {
         isLoading(false);
         Fluttertoast.showToast(
             msg: '${sigin?.message}',
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.blue,
             textColor: Colors.white,
             fontSize: 16.0);
       }
     }
     catch(e){
       rethrow;
     }
     finally{
       isLoading(false);
     }
   }


  Future<void> Rotp() async {
    isLoading(true);
    try{
      var sigin = await Loginervice.postRotp(email);
      if (sigin?.status == 200) {
        isLoading(false);
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        isLoading(false);
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.back();
      }
    }
    catch(e){
      rethrow;
    }
    finally{
      isLoading(false);
    }
  }


  getInitialFormattedNumber(String format, String str) {
    if (str == '') return '';
    var mask = format;
    str.split("").forEach((item) => {mask = mask.replaceFirst('x', item)});
    return mask.replaceAll('x', "");
  }
}
