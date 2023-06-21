import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/reusability/utils/shared_prefs.dart';
import 'package:playze/reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../../app/modules/bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';
import '../../generated/locales.g.dart';

class CustomStartDrawer extends StatefulWidget {
  const CustomStartDrawer({Key? key}) : super(key: key);

  @override
  State<CustomStartDrawer> createState() => _CustomStartDrawerState();
}

final controller =
    Get.put<BottomNavigationBarController>(BottomNavigationBarController());

class _CustomStartDrawerState extends State<CustomStartDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff0264C5),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: customDrawer(),
      ),
    );
  }

  Widget customDrawer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR);
              controller.selectedIndex.value = 0;
              log(controller.selectedIndex.value);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.07,
                    width: Get.width * 0.08,
                    child: Image.asset("assets/images/Explore.png"),
                  ),
                  w(10),
                  Text(
                    LocaleKeys.buttons_Explore.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR);
              controller.selectedIndex.value = 1;
              log(controller.selectedIndex.value);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.07,
                    width: Get.width * 0.08,
                    child: Image.asset("assets/images/dil2.png"),
                  ),
                  w(10),
                  const Text(
                    "Wishlist",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR);
              controller.selectedIndex.value = 2;
              log(controller.selectedIndex.value);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              width: Get.width,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.07,
                    width: Get.width * 0.08,
                    child: Image.asset("assets/images/homeback.png"),
                  ),
                  w(10),
                  const Text(
                    "My Plan",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.PLAYZE_WORKSPACE);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.07,
                    width: Get.width * 0.08,
                    child: Image.asset("assets/images/dp.png"),
                  ),
                  w(10),
                  const Text(
                    "Playze Workspace",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR);
              controller.selectedIndex.value = 3;
              log(controller.selectedIndex.value);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.03,
                    width: Get.width * 0.08,
                    child: Image.asset("assets/images/man.png"),
                  ),
                  w(10),
                  const Text(
                    "My Profile",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.NOTIFICATIONS);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.07,
                    width: Get.width * 0.08,
                    child: Image.asset("assets/images/notifications.png"),
                  ),
                  w(10),
                  const Text(
                    "Notifications",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.SETTINGS);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.035,
                    width: Get.width * 0.09,
                    child: Image.asset("assets/images/settings.png"),
                  ),
                  w(10),
                  const Text(
                    "Settings",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.ABOUTUS);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.035,
                    width: Get.width * 0.09,
                    child: Image.asset("assets/images/info.png"),
                  ),
                  w(10),
                  const Text(
                    "About Us",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(5),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.CONTACT_US);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.035,
                    width: Get.width * 0.09,
                    child: Image.asset("assets/images/call.png"),
                  ),
                  w(10),
                  const Text(
                    "Contact Us",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          h(20),
          GestureDetector(
            onTap: () {
              SharedPrefs().value.write(SharedPrefs.setBool, false);
              Get.offNamedUntil(Routes.SIGNIN, (route) => false);
            },
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  SizedBox(
                    height: Get.height * 0.035,
                    width: Get.width * 0.09,
                    child: Image.asset("assets/images/logout.png"),
                  ),
                  w(10),
                  const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
