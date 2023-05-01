import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  final controller = Get.put<ContactUsController>(ContactUsController());
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
                        Text("Contact Us",
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
          width: Get.width,
          margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTextField(
                  borderColor: Colors.grey,
                  borderRadius: 10,
                  hintTextStyle: TextStyle(color: Colors.grey),
                  context: context,
                  controller: controller.FName,
                  hintText: "Full Name",
                ),
                h(15),
                InputTextField(
                  borderColor: Colors.grey,
                  borderRadius: 10,
                  hintTextStyle: TextStyle(color: Colors.grey),
                  context: context,
                  controller: controller.Email,
                  hintText: "Email",
                ),
                h(15),

                InputTextField(
                  height: Get.height*0.2,
                  borderColor: Colors.grey,
                  borderRadius: 10,
                  hintTextStyle: TextStyle(color: Colors.grey),
                  context: context,
                  controller: controller.Massage,
                  hintText: "Massage",
                ),
                h(270),
                ButtonWithStyle(
                  onPressed: () {

                  },
                  textVal: LocaleKeys.buttons_submit.tr.toUpperCase(),
                  btnwidth: Get.width,
                ),
                h(80),
              ],
            ),
          ),
        ),
        bottomNavigationBar: btmbar(fromOther: true,),
      extendBody: true,
    );
  }
}
