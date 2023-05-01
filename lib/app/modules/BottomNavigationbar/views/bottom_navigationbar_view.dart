import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/app/modules/home/views/home_view.dart';
import 'package:playze/app/modules/myplan/views/myplan_view.dart';
import 'package:playze/app/modules/profile/views/profile_view.dart';

import '../../wishlist/views/wishlist_view.dart';
import '../controllers/bottom_navigationbar_controller.dart';

class BottomNavigationbarView extends GetView<BottomNavigationbarController> {
  var controller = Get.put(BottomNavigationbarController());
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Widget> screens = [
    HomeView(),
    WishlistView(),
    MyplanView(),
    ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationbarController>(
        builder: (controller) {
        return Scaffold(
          extendBody: true,
          key: scaffoldKey,
          body: Obx(()=>screens.elementAt(controller.selectedIndex),),
          bottomNavigationBar: btmbar(),
        );
      }
    );
  }
}
