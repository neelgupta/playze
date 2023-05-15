import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1, //
        flexibleSpace: Container(
          height: Get.height * 0.2,
          color: Color(0xff0264C5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 10, bottom: 10,right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _key.currentState!.openDrawer();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                        ),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                image:
                                AssetImage("assets/images/menu.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Settings",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,

                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
        drawer: CsDrawer(),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.offAndToNamed(Routes.PROFILE);
              },
              child: Container(
                height: Get.height*0.07,
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image(
                          image:
                          AssetImage("assets/images/man.png"),
                          color: Colors.black,
                        )
                    ),
                    w(20),
                    Text(LocaleKeys.buttons_Account.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,

                        )),
                  ],
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: (){
              },
              child: Container(
                height: Get.height*0.07,
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image(
                          image:
                          AssetImage("assets/images/notification.png"),
                          color: Colors.black,
                        )
                    ),
                    w(20),
                    Text(LocaleKeys.buttons_Notifications.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,

                        )),
                    Spacer(),
        GetBuilder<SettingsController>(
              builder: (controller) {
                return  Switch(
                  activeColor: Colors.orange,
                  inactiveThumbColor: Colors.orange,
                  value: controller.isSwitched,
                  onChanged: (value) {
                    print("VALUE : $value");
                    controller.isSwitched = !controller.isSwitched;
                    controller.update();
                  },
                );
              }
        )

                  ],
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: (){
                Get.offAndToNamed(Routes.CHANGE_PASSWORD);
              },
              child: Container(
                height: Get.height*0.07,
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image(
                          image:
                          AssetImage("assets/images/lock.png"),
                          color: Colors.black,
                        )
                    ),
                    w(20),
                    Text(LocaleKeys.buttons_Change_Password.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,

                        )),
                  ],
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: (){
                Get.offAndToNamed(Routes.TERMS_CONDITIONS);
              },
              child: Container(
                height: Get.height*0.07,
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(1),
                        height: Get.height*0.07,
                        width: Get.width*0.08,
                        child: Image(
                          image:
                          AssetImage("assets/images/description.png"),
                          color: Colors.black,
                        )
                    ),
                    w(20),
                    Text(LocaleKeys.buttons_Terms_Conditions.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,

                        )),
                  ],
                ),
              ),
            ),
            Divider()
          ],
        ),
      ),
        bottomNavigationBar: btmbar(fromOther: true,),
      extendBody: true,
    );
  }
}
