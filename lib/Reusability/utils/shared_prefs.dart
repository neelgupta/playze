import 'package:get_storage/get_storage.dart';

class SharedPrefs {
  final value = GetStorage();

  static String userIdKey = "userIdKey";
  static String tokenKey = "tokenKey";
  static String idKey = "idKey";
  static String firstNameKey = "firstNameKey";
  static String lastNameKey = "lastNameKey";
  static String passwordKey = "passwordKey";
  static String mobileNumbarKey = "mobileNumbarKey";
  static String emailKey = "emailKey";
  static String otpKey = "otpKey";
  static String childrenKey = "childrenKey";
  static String interestKey = "interestKey";
  static String setBool = "setBool";

  // setotpData({
  //    String? token,
  //    String? usersId,
  // }) {
  //   value.write(userIdKey, usersId!);
  //   value.write(tokenKey, token!);
  //
  // }

  // getotpData({
  //  String? token,
  //  String? usersId,
  //   }) {
  //   value.read(tokenKey);
  //   value.read(userIdKey);
  // }

  // setLoginData({
  //   required String token,
  //   required String fname,
  //   required String lname,
  //   required String password,
  //   required String mnumber,
  //   required String email,
  // }) {
  //   Util.prefs!.setString(tokenKey, token);
  //   Util.prefs!.setString(fnamenKey, fname);
  //   Util.prefs!.setString(lnameKey, lname);
  //   Util.prefs!.setString(passwordKey, password);
  //   Util.prefs!.setString(mnumbarKey, mnumber);
  //   Util.prefs!.setString(emailKey, email);
  //
  // }
  //
  // setsignupData({
  //   required String id,
  //   required String fname,
  //   required String lname,
  //   required String password,
  //   required String mnumber,
  //   required String email,
  //   required String otp,
  // }) {
  //   Util().prefs!.setString(userIdKey, id);
  //   Util.prefs!.setString(fnamenKey, fname);
  //   Util.prefs!.setString(lnameKey, lname);
  //   Util.prefs!.setString(passwordKey, password);
  //   Util.prefs!.setString(mnumbarKey, mnumber);
  //   Util.prefs!.setString(emailKey, email);
  //   Util.prefs!.setString(otpKey, otp);
  //
  // }
  //
  // getsignupData({
  //   required String id,
  //   required String fname,
  //   required String lname,
  //   required String password,
  //   required String mnumber,
  //   required String email,
  //   required String otp,
  //   required String children,
  //   required String interest,
  // }) {
  //   Util.prefs!.getString(userIdKey);
  //   Util.prefs!.getString(fnamenKey);
  //   Util.prefs!.getString(lnameKey);
  //   Util.prefs!.getString(passwordKey);
  //   Util.prefs!.getString(mnumbarKey);
  //   Util.prefs!.getString(emailKey);
  //   Util.prefs!.getString(otpKey);
  //   Util.prefs!.getString(childrenKey);
  //   Util.prefs!.getString(interestKey);
  //
  // }
  //
  // getLoginData({
  //   required String token,
  //   required String fname,
  //   required String lname,
  //   required String password,
  //   required String mnumber,
  //   required String email,
  // }) {
  //   Util.prefs!.getString(tokenKey);
  //   Util.prefs!.getString(fnamenKey);
  //   Util.prefs!.getString(lnameKey);
  //   Util.prefs!.getString(passwordKey);
  //   Util.prefs!.getString(mnumbarKey);
  //   Util.prefs!.getString(emailKey);
  //
  // }
  //
  // getotpData({
  //   String? token,
  //   String? usersId,
  // }) {
  //   Util.prefs!.getString(userIdKey);
  //   Util.prefs!.getString(tokenKey);
  //
  // }
}
