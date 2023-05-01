import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/modules/BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../../generated/locales.g.dart';

class CsDrawer extends StatefulWidget {
  const CsDrawer({Key? key}) : super(key: key);

  @override
  State<CsDrawer> createState() => _CsDrawerState();
}
final controller = Get.put<BottomNavigationbarController>(BottomNavigationbarController());
class _CsDrawerState extends State<CsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff0264C5),
      child:Container(
        margin: EdgeInsets.all(20),
        child: CustomDrawer(),
      ),
    );
  }
  Widget CustomDrawer(){
    return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR);
                  controller.selectedIndex = 0;
                  print(controller.selectedIndex);
                  },
                child: Container(
                  height: Get.height*0.07,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image.asset("assets/images/Explore.png"),
                      ),
                      w(10),
                      Text(LocaleKeys.buttons_Explore.tr,style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              h(5),
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR);
                  controller.selectedIndex = 1;
                  print(controller.selectedIndex);
                },
                child: Container(
                  height: Get.height*0.07,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image.asset("assets/images/dil2.png"),
                      ),
                      w(10),
                      Text("Wishlist",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              h(5),
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR);
                  controller.selectedIndex = 2;
                  print(controller.selectedIndex);
                },
                child: Container(
                  height: Get.height*0.07,
                  width: Get.width,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image.asset("assets/images/homeback.png"),
                      ),
                      w(10),
                      Text("My Plan",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              h(5),
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.PLAYZE_WORKSPACE);
                },
                child: Container(
                  height: Get.height*0.07,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image.asset("assets/images/dp.png"),
                      ),
                      w(10),
                      Text("Playze Workspace",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              h(5),
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.BOTTOM_NAVIGATIONBAR);
                  controller.selectedIndex = 3;
                  print(controller.selectedIndex);
                },
                child: Container(
                  height: Get.height*0.07,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.03,
                        width: Get.width*0.08,
                        child: Image.asset("assets/images/man.png"),
                      ),
                      w(10),
                      Text("My Profile",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              h(5),
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.NOTIFICATIONS);
                },
                child: Container(
                  height: Get.height*0.07,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image.asset("assets/images/notifications.png"),
                      ),
                      w(10),
                      Text("Notifications",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              h(5),
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.SETTINGS);
                },
                child: Container(
                  height: Get.height*0.07,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.035,
                        width: Get.width*0.09,
                        child: Image.asset("assets/images/settings.png"),
                      ),
                      w(10),
                      Text("Settings",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              h(5),
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.ABOUTUS);
                },
                child: Container(
                  height: Get.height*0.07,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.035,
                        width: Get.width*0.09,
                        child: Image.asset("assets/images/info.png"),
                      ),
                      w(10),
                      Text("About Us",style: TextStyle(color: Colors.white,fontSize: 16),),

                    ],
                  ),
                ),
              ),
              h(5),
              GestureDetector(
                onTap: (){
                  Get.offAndToNamed(Routes.CONTACT_US);
                },
                child: Container(
                  height: Get.height*0.07,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height*0.035,
                        width: Get.width*0.09,
                        child: Image.asset("assets/images/call.png"),
                      ),
                      w(10),
                      Text("Contact Us",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              h(20),
              Container(
                height: Get.height*0.07,
                child: Row(
                  children: [
                    Container(
                      height: Get.height*0.035,
                      width: Get.width*0.09,
                      child: Image.asset("assets/images/logout.png"),
                    ),
                    w(10),
                    Text("Logout",style: TextStyle(color: Colors.white,fontSize: 16),),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
