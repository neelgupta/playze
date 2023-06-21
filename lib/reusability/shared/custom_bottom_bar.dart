import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/modules/bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';

class CustomBottomBar extends StatelessWidget {
  final bool fromOther;
  const CustomBottomBar({Key? key, this.fromOther = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<BottomNavigationBarController>(
      builder: (bottomController) {
        return FloatingNavbar(
          selectedBackgroundColor: Colors.orange,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          elevation: 200,
          backgroundColor: const Color(0xff0264C5),
          onTap: (index) => fromOther
              ? bottomController.onOtherScreen(index)
              : bottomController.selectedIndex.value = index,
          currentIndex: bottomController.selectedIndex.value,
          items: [
            FloatingNavbarItem(
              customWidget: SizedBox(
                height: Get.height * 0.04,
                width: Get.width * 0.07,
                child: const Image(
                  image: AssetImage("assets/images/composh.png"),
                  width: 30,
                ),
              ),
              title: 'Explore',
            ),
            FloatingNavbarItem(
              customWidget: SizedBox(
                height: Get.height * 0.04,
                width: Get.width * 0.06,
                child: const Image(
                  image: AssetImage("assets/images/dil.png"),
                  width: 25,
                ),
              ),
              title: 'Wishlist',
            ),
            FloatingNavbarItem(
              customWidget: SizedBox(
                height: Get.height * 0.04,
                width: Get.width * 0.07,
                child: const Image(
                  image: AssetImage("assets/images/map.png"),
                  width: 30,
                ),
              ),
              title: 'My Plan',
            ),
            FloatingNavbarItem(
              customWidget: SizedBox(
                height: Get.height * 0.04,
                width: Get.width * 0.06,
                child: const Image(
                  image: AssetImage("assets/images/man.png"),
                  width: 30,
                ),
              ),
              title: 'Profile',
            ),
          ],
        );
      },
    );
  }
}
