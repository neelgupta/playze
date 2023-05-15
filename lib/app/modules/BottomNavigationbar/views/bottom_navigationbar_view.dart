import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/modules/home/views/home_view.dart';
import 'package:playze/app/modules/myplan/views/myplan_view.dart';
import 'package:playze/app/modules/profile/views/profile_view.dart';

import '../../../routes/app_pages.dart';
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
          body: Stack(
            children: [
              Obx(()=>screens.elementAt(controller.selectedIndex),),
              Obx(() => controller.selectedIndex == 0?controller.Dpop.value?Positioned(
                bottom: 80,
                child: Container(
                    height: Get.height*0.25,
                    width: Get.width,
                    child: Card(
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        height: Get.height*0.25,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Container(
                                          child: Image(image: AssetImage("assets/images/dil.png")),
                                          height: Get.height*0.02,
                                        ),
                                      )
                                    ],
                                  ),
                                  height: Get.height*0.12,
                                  width: Get.width*0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Children’s Museum"),
                                      SizedBox(
                                        height: Get.
                                        height*0.01,),
                                      Row(
                                        children: [
                                          Container(
                                              height: Get.height*0.02,
                                              child: Image(image: AssetImage("assets/images/star.png"))),
                                          SizedBox(width: Get.width*0.02,),
                                          Text("4.0",style: TextStyle(fontSize: 16),),
                                          SizedBox(width: Get.width*0.02,),
                                          Text("150 Reviews",style: TextStyle(fontSize: 12,color: Colors.grey),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.
                                        height*0.01,),
                                      Row(
                                        children: [
                                          Container(
                                              height: Get.height*0.02,
                                              child: Image(image: AssetImage("assets/images/log.png"))),
                                          SizedBox(width: Get.width*0.02,),
                                          Container(width:Get.width*0.35,child: Text("100 Laurier Street, Gatineau..",style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 12,color: Colors.grey),)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.
                                        height*0.01,),
                                      Row(
                                        children: [
                                          Container(
                                              height: Get.height*0.02,
                                              child: Image(image: AssetImage("assets/images/walking.png"))),
                                          SizedBox(width: Get.width*0.02,),
                                          Text("2 min",style: TextStyle(fontSize: 12,color: Colors.grey),),
                                          SizedBox(width: Get.width*0.02,),
                                          Text("1 km away",style: TextStyle(fontSize: 12,color: Colors.grey),),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Image(image: AssetImage("assets/images/go.png"),width: 25,),

                                    Text("  Go"),
                                  ],
                                ),
                                SizedBox(width: Get.width*0.025,),
                                Row(
                                  children: [
                                    Image(image: AssetImage("assets/images/plan.png"),width: 25,),
                                    Text("  My Plan"),
                                  ],
                                ),
                                ButtonWithStyle(
                                  onPressed: () {
                                    Get.toNamed(Routes.FULL_DETAILS);
                                  },
                                  textVal: "Details",
                                  btnwidth: Get.width*0.3,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            )
                          ],
                        ),
                      ),
                    )
                ),
              ):SizedBox():SizedBox())
            ],
          ),
          bottomNavigationBar: btmbar(),
        );
      }
    );
  }
}
