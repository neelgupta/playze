import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
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
                        Text("My Profile",
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
        height: Get.height,
        margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: Get.height*0.1,
                    width: Get.width*0.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage("assets/images/NoPath.png"))
                    ),
                  ),
                  w(15),
                  Text("Kevin Zegers",style: TextStyle(fontSize: 18),),
                  Spacer(),
                  Text(LocaleKeys.labels_Edit.tr,style: TextStyle(fontSize: 14),),
                  w(10),
                  GestureDetector(
                    onTap: (){
                      Get.offNamed(Routes.EDIT_PROFILE);
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      height: Get.height*0.07,
                      width: Get.width*0.08,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                          shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/images/nounedit.png"),
                    ),
                  ),
                ],
              ),
              Divider(),
              h(5),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((LocaleKeys.labels_name.tr),style: TextStyle(fontSize: 16),),
                      h(5),
                      Text(("Kevin Zegers"),style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ],
                  )
              ),
              h(5),
              Divider(),
              h(5),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((LocaleKeys.labels_email.tr),style: TextStyle(fontSize: 16),),
                      h(5),
                      Text(("Kevin@gmail.com"),style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ],
                  )
              ),
              h(5),
              Divider(),
              h(5),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((LocaleKeys.labels_phone.tr),style: TextStyle(fontSize: 16),),
                      h(5),
                      Text(("+1 985 547 2222"),style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ],
                  )
              ),
              h(5),
              Divider(),
              h(5),
              Container(
                margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((LocaleKeys.labels_Your_Location.tr),style: TextStyle(fontSize: 16),),
                      h(5),
                      Text(("Dieppe, Canada."),style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ],
                  )
              ),
              h(25),
              Text((LocaleKeys.labels_Children_information.tr),style: TextStyle(fontSize: 20,color: Colors.black),),
              h(15),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((LocaleKeys.labels_children.tr + " " +LocaleKeys.labels_name.tr),style: TextStyle(fontSize: 16),),
                      h(5),
                      Text(("Zoe Saldana"),style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ],
                  )
              ),
              h(5),
              Divider(),
              h(5),
              Container (
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((LocaleKeys.labels_children.tr + " " + LocaleKeys.labels_age.tr),style: TextStyle(fontSize: 16),),
                      h(5),
                      Text(("6 Years"),style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ],
                  )
              ),
              h(5),
              Divider(),
            ],
          ),
        ),
      ),

      extendBody: true,
    );
  }
}
