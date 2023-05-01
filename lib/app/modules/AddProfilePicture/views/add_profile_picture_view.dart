import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/add_profile_picture_controller.dart';

class AddProfilePictureView extends GetView<AddProfilePictureController> {
  const AddProfilePictureView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        color: Colors.blue,
        padding: EdgeInsets.only(left: 10,right: 10,top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: Get.width*0.4,child: Image.asset("assets/images/appIcon.png")),
              h(20),
              Text(LocaleKeys.text_Add_Profile_Picture.tr,style: AppTextStyle.size18Medium.copyWith(fontSize: 20,fontWeight: FontWeight.w600)),
              h(20),
              h(10),
              Stack(
                children: [
                  GetBuilder<AddProfilePictureController>(
                      builder: (controller) {
                        return GestureDetector(
                          onTap:(){
                            controller.selectFile();
                          },
                          child: Container(
                            height: Get.height*0.08,
                            width: Get.width*0.2,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: controller.isPicked.value ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: FileImage(controller.imageFile!),fit: BoxFit.fill)
                                ),
                                ): Image(image: AssetImage("assets/images/noman.png")),
                          ),
                        );
                      }
                  ),
                  Positioned(
                    bottom: 5,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        height: Get.height*0.03,
                        width: Get.width*0.06,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset("assets/images/add.png"),
                      ),
                    ),
                  ),
                ],
              ),
              h(10),
              Text(LocaleKeys.labels_Profile.tr + " " + "Name",style: AppTextStyle.size14Medium.copyWith(letterSpacing: 1,fontWeight: FontWeight.w600)),
              h(10),
              InputTextField(
                context: context,
                controller: controller.otpController,
                hintText: "Add Profile Name",
              ),
              h(50),
              ButtonWithStyle(
                onPressed: () {
                  Get.toNamed(Routes.CHOOSE_PROFILE_PICTURE);
                },
                textVal: LocaleKeys.buttons_save.tr.toUpperCase(),
                btnwidth: Get.width,
              ),
              h(10),
            ],
          ),
        ),
      ),
    );
  }
}
