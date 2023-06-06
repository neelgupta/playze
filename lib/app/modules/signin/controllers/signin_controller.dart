import 'dart:developer';
import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/app/data/modal/login.dart';
import 'package:playze/app/data/service/loginservice.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/main.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:device_info_plus/device_info_plus.dart';


class SigninController extends GetxController {
  //TODO: Implement SigninController
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  TextEditingController passwordController = TextEditingController();
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  loginService Loginervice = loginService();
  final count = 0.obs;
  var emailstatus = false.obs;
  var passwordstatus = false.obs;
  String status = "";
  var firetoken;
  String? deviceId;
  bool _initialized = false;
  LoginModel? a;
  List<Child> childrenList = [];
  @override
  void onInit() {
    super.onInit();
    // configPushNotification();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> signin() async {
    isLoading(true);
    try{
      LoginModel? sigin = await Loginervice.postlogin(
          emailController.text.trim(),
          passwordController.text.trim()
      );
      log("sigin : ${sigin}");
      if (sigin?.status == 200) {
        SharedPrefs().value.write(SharedPrefs.userIdKey, sigin?.data?.id ?? " ");
        SharedPrefs().value.write(SharedPrefs.tokenKey, sigin?.data?.token ??' ');
        SharedPrefs().value.write(SharedPrefs.emailKey, sigin?.data?.email ?? " ");
        SharedPrefs().value.write(SharedPrefs.fnamenKey, sigin?.data?.firstName ?? " ");
        SharedPrefs().value.write(SharedPrefs.lnameKey, sigin?.data?.lastName ?? " ");
        SharedPrefs().value.write(SharedPrefs.mnumbarKey, sigin?.data?.mobileNumber ?? " ");
        a?.data?.children?.forEach((element) {
          childrenList.add(element);
        });
        SharedPrefs().value.write('favoriteArticles', childrenList.cast<Child>());
        SharedPrefs().value.listenKey(SharedPrefs.childrenKey, (value){
          print('new key is $value');
        });
        for (int i = 0; i < childrenList.length; i++) {
          debugPrint(
              'name ${childrenList[i].name} age: ${childrenList[i].age}');
        }
        // SharedPrefs().value.read(SharedPrefs.childrenKey).forEach((element) {
        //   childrenList.add(element);
        //   // lip.add(element.name);
        // });
        SharedPrefs().value.write(SharedPrefs.setBool, true);
        print(SharedPrefs().value.read(SharedPrefs.setBool));
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.offNamedUntil(Routes.BOTTOM_NAVIGATIONBAR,(route) => false,);
      }else{
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    catch(e){
      rethrow;
    }
    finally{
      isLoading(false);
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
  //   print('token :' + firetoken);
  //   print('deviceid :' + deviceId!);
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
  //   print(firebaseToken);
  // }
  //
  // getDeviceInfo() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     deviceToken = androidInfo.id!;
  //     print('Device id is ${androidInfo.id}'); // e.g. "Moto G (4)"
  //   } else {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     deviceToken = iosInfo.identifierForVendor!;
  //     print('Device id is ${iosInfo.identifierForVendor!}');
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
  //       print('Flutter Notificaction message from main');
  //       print('Get Initial Message');
  //     }
  //   });
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     print('Get Message');
  //     print(notification!.title);
  //     print(notification.body);
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
  //             // TODO add a proper drawable resource to android, for now using
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
  //     print('A new onMessageOpenedApp event was published!');
  //     print(message.notification!.title);
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
