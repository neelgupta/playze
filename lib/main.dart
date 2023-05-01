import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/generated/locales.g.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      translationsKeys: AppTranslation.translations,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      // theme: AppTheme.theme,
      navigatorKey: Get.key,
    ),
  );
}
