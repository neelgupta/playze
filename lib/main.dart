// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:playze/generated/locales.g.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
// import 'package:firebase_core/firebase_core.dart';
import 'app/data/provider/filter_provider.dart';
import 'app/routes/app_pages.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }
//
// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;
//
// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<FilterProvider>(create: (_) => FilterProvider()),
      ],
      child: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        translationsKeys: AppTranslation.translations,
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        // theme: AppTheme.theme,
        navigatorKey: Get.key,
      ),
    ),
  );
}
