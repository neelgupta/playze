import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:playze/app/modules/BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';

class btmbar extends StatelessWidget {
  final bool fromOther;
  const btmbar({Key? key, this.fromOther = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<BottomNavigationbarController>(builder: (s) {
      return  Container(
          child:  FloatingNavbar(
            selectedBackgroundColor: Colors.orange,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            elevation: 200,
            backgroundColor: Color(0xff0264C5),
            onTap: (index) => fromOther ? s.onOtherScreen(index) : s.selectedIndex = index,
            currentIndex: s.selectedIndex,
            items: [
              FloatingNavbarItem(customWidget: Container(
                  height: Get.height*0.04,
                  width: Get.width*0.07,
                  child: Image(image: AssetImage("assets/images/composh.png"),width: 30,)), title: 'Explore'),
              FloatingNavbarItem(customWidget: Container( height: Get.height*0.04,
                  width: Get.width*0.06,child: Image(image: AssetImage("assets/images/dil.png"),width: 25,)), title: 'Wishlist'),
              FloatingNavbarItem(customWidget: Container( height: Get.height*0.04,
                  width: Get.width*0.07,child: Image(image: AssetImage("assets/images/map.png"),width: 30,)), title: 'My Plan'),
              FloatingNavbarItem(customWidget: Container( height: Get.height*0.04,
                  width: Get.width*0.06,child: Image(image: AssetImage("assets/images/man.png"),width: 30,)), title: 'Profile'),
            ],
          )
        );
    }
    );
  }
}
