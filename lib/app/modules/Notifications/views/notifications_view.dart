import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/utils/util.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
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
                        Text("Notifications",
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
        margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
        height: Get.height,
        width: Get.width,
        child: ListView.builder(itemCount: 10,itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                height: Get.height*0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.orange)
                ),
                child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    height: Get.height*0.07,
                    width: Get.width*0.05,
                    child: Container(
                      height: Get.height*0.02,
                      width: Get.width*0.03,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: Get.height*0.07,
                    width: Get.width*0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut",style: TextStyle(fontSize: 12),),
                          width: Get.width*0.8,
                        ),
                        h(5),
                        Text("09:49 AM",style: TextStyle(fontSize: 10),)
                      ],
                    ),
                  ),

                ],
                ),
              ),
              h(10)
            ],
          );
        },)
      ),
        bottomNavigationBar: btmbar(fromOther: true),
      extendBody: true,
    );
  }
}
