import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../../../../Reusability/shared/commonTextField.dart';
import '../../../../generated/locales.g.dart';
import '../controllers/choose_profile_picture_controller.dart';

class ChooseProfilePictureView extends GetView<ChooseProfilePictureController> {
  const ChooseProfilePictureView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
        child: Container(
          margin: EdgeInsets.only(top: 150),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: Get.width*0.4,child: Image.asset("assets/images/appIcon.png")),
                h(20),
                Text("Choose Profile Picture",style: AppTextStyle.size18Medium.copyWith(fontSize: 20,fontWeight: FontWeight.w600)),
                h(20),
                h(10),
                GetBuilder<ChooseProfilePictureController>(
                    builder: (controller) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              controller.selectcameraFile();
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              height: Get.height*0.06,
                              width: Get.width*0.15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset("assets/images/photocamera.png"),
                            ),
                          ),
                          w(10),
                          GestureDetector(
                            onTap: (){
                              controller.selectFile();
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              alignment: Alignment.center,
                              height: Get.height*0.06,
                              width: Get.width*0.15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset("assets/images/galri.png"),
                            ),
                          ),
                        ],
                      );
                    }
                ),
                h(20),
                Text(LocaleKeys.labels_The_Classics.tr,style: AppTextStyle.size18Medium.copyWith(fontSize: 16,fontWeight: FontWeight.w600)),
                Container(
                  height: Get.height*0.17,
                  child: GridView.builder(itemCount:controller.images.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10), itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(image: AssetImage(controller.images[index]))
                      ),
                    );
                  },),
                ),
                h(20),
                Text("Emojis",style: AppTextStyle.size18Medium.copyWith(fontSize: 16,fontWeight: FontWeight.w600)),
                Container(
                  height: Get.height*0.17,
                  child: GridView.builder(itemCount:controller.images.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10), itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(image: AssetImage(controller.images[index]))
                      ),
                    );
                  },),
                ),
                h(20),
                Text("The Boss Baby: Back in Business",style: AppTextStyle.size18Medium.copyWith(fontSize: 16,fontWeight: FontWeight.w600)),
                Container(
                  height: Get.height*0.17,
                  child: GridView.builder(itemCount:controller.images.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10), itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(image: AssetImage(controller.images[index]))
                      ),
                    );
                  },),
                ),
                h(20),
                ButtonWithStyle(
                  onPressed: () {
                    Get.toNamed(Routes.BOTTOM_NAVIGATIONBAR);
                  },
                  textVal: LocaleKeys.buttons_save.tr.toUpperCase(),
                  btnwidth: Get.width,
                ),
                h(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
