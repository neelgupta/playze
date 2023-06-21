import 'dart:developer';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/signup_model.dart';
import 'package:playze/reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/login_model.dart';
import 'package:playze/app/data/service/login_service.dart';
import 'package:playze/app/routes/app_pages.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:device_info_plus/device_info_plus.dart';

class SignInController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isForgotLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPassController = TextEditingController();
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  LoginService loginervice = LoginService();
  final count = 0.obs;
  // var emailstatus = false.obs;
  // var passwordstatus = false.obs;
  String status = "";
  // var firetoken;
  String? deviceId;

  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgotPassFormKey = GlobalKey<FormState>();
  // LoginModel? a;
  List<ChildData> childrenList = [];

  Future<void> signInMethod() async {
    isLoading(true);
    try {
      LoginModel? signIn = await loginervice.loginMethod(
          emailController.text.trim(), passwordController.text.trim());
      log("signIn : $signIn");
      if (signIn != null) {
        if (signIn.status == 200) {
          SharedPrefs().value.write(SharedPrefs.userIdKey, signIn.data.id);
          SharedPrefs().value.write(SharedPrefs.tokenKey, signIn.data.token);
          SharedPrefs().value.write(SharedPrefs.emailKey, signIn.data.email);
          SharedPrefs()
              .value
              .write(SharedPrefs.firstNameKey, signIn.data.firstName);
          SharedPrefs()
              .value
              .write(SharedPrefs.lastNameKey, signIn.data.lastName);
          SharedPrefs()
              .value
              .write(SharedPrefs.mobileNumbarKey, signIn.data.mobileNumber);
          for (var element in signIn.data.children) {
            childrenList.add(element);
          }
          SharedPrefs()
              .value
              .write('favoriteArticles', childrenList.cast<ChildData>());
          SharedPrefs().value.listenKey(SharedPrefs.childrenKey, (value) {
            log('new key is $value');
          });
          for (int i = 0; i < childrenList.length; i++) {
            log('name ${childrenList[i].name} age: ${childrenList[i].age}');
          }
          // SharedPrefs().value.read(SharedPrefs.childrenKey).forEach((element) {
          //   childrenList.add(element);
          //   // lip.add(element.name);
          // });
          SharedPrefs().value.write(SharedPrefs.setBool, true);
          log("${SharedPrefs().value.read(SharedPrefs.setBool)} -- ");
          Fluttertoast.showToast(
            msg: signIn.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Get.offNamedUntil(
            Routes.BOTTOM_NAVIGATIONBAR,
            (route) => false,
          );
        } else {
          Fluttertoast.showToast(
            msg: signIn.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Something went wrong. Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> forgotPasswordFunction({placeId}) async {
    try {
      // var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      isForgotLoading(true);
      bool isSuccess = await loginervice.forgotPasswordMethod(
            emailID: forgotPassController.text.trim(),
          ) ??
          false;
      if (isSuccess) {
        Get.back();
      }

      update();
    } catch (e) {
      log(e.toString());
    } finally {
      isForgotLoading(false);
    }
  }
  // Future<String?> _getId() async {
  //   // var deviceInfo = DeviceInfoPlugin();
  //   if (GetPlatform.isIOS) {
  //     // import 'dart:io'
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.androidId; // unique ID on Android
  //   }
  // }
  //
  // void configPushNotification() async {
  //   if (GetPlatform.isIOS) {
  //     if (!_initialized) {
  //       // For iOS request permission first.
  //       await _firebaseMessaging.requestPermission().then((value) async {
  //         firetoken = await _firebaseMessaging.getToken();
  //       });
  //       _initialized = true;
  //     }
  //   } else {
  //     firetoken = await _firebaseMessaging.getToken();
  //   }
  //   deviceId = await _getId();
  //
  //   log('token :' + firetoken);
  //   log('deviceid :' + deviceId!);
  //   SharedPrefs().value.write(SharedPrefs.DiviseKey, deviceId ?? "");
  // }
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //
  // getFirebaseToken() async {
  //   if (Platform.isIOS) {
  //     await _firebaseMessaging.requestPermission().then((value) async {
  //       firebaseToken = (await _firebaseMessaging.getToken())!;
  //     });
  //   } else {
  //     firebaseToken = (await _firebaseMessaging.getToken())!;
  //   }
  //   log(firebaseToken);
  // }
  //
  // getDeviceInfo() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     deviceToken = androidInfo.id!;
  //     log('Device id is ${androidInfo.id}'); // e.g. "Moto G (4)"
  //   } else {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     deviceToken = iosInfo.identifierForVendor!;
  //     log('Device id is ${iosInfo.identifierForVendor!}');
  //   }
  // }
  //
  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  //
  // Future<void> getNotification() async {
  //   /// Create an Android Notification Channel.
  //   ///
  //   /// We use this channel in the `AndroidManifest.xml` file to override the
  //   /// default FCM channel to enable heads up notifications.
  //   channel =  const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title// description
  //     importance: Importance.high,
  //   );
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);
  //   var androiInit =
  //   const AndroidInitializationSettings('@mipmap/ic_launcher'); //for logo
  //   var iosInit = const DarwinInitializationSettings();
  //   var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
  //   flutterLocalNotificationsPlugin.initialize(initSetting);
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage? message) {
  //     if (message != null) {
  //       log('Flutter Notificaction message from main');
  //       log('Get Initial Message');
  //     }
  //   });
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     log('Get Message');
  //     log(notification!.title);
  //     log(notification.body);
  //     if (notification.title != null) {
  //       flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           iOS: const DarwinNotificationDetails(),
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             "yuuyyufytf",
  //             //      one that already exists in example app.
  //             icon: '@mipmap/ic_launcher',
  //           ),
  //         ),
  //         payload: "${notification.title}",
  //       );
  //     }
  //   });
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     log('A new onMessageOpenedApp event was published!');
  //     log(message.notification!.title);
  //   });
  // }
  //
  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   return await Geolocator.getCurrentPosition();
  // }
}
