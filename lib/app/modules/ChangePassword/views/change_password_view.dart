import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../../Reusability/shared/textStyle.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                        ),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                image:
                                AssetImage("assets/images/back.png"),
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
                        Text(LocaleKeys.buttons_Change_Password.tr,
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
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        )
            : Container(
              height: Get.height,
              margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.buttons_Current_Password.tr,style: TextStyle(),),
                    h(5),
                    Container(
                      height: Get.height*0.065,
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.00)
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: controller.CurrentPassword,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: LocaleKeys.buttons_Current_Password.tr,
                            hintStyle: AppTextStyle.size12Regular
                        ),
                      ),
                    ),
                    // InputTextField(
                    //   borderColor: Colors.grey,
                    //   borderRadius: 10,
                    //   hintTextStyle: TextStyle(color: Colors.grey),
                    //   context: context,
                    //   controller: controller.CurrentPassword,
                    //   hintText: LocaleKeys.buttons_Current_Password.tr,
                    // ),
                    h(15),
                    Text(LocaleKeys.buttons_Current_Password.tr,style: TextStyle(),),
                    h(5),
                    Container(
                      height: Get.height*0.065,
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.00)
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: controller.NewPassword,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: LocaleKeys.buttons_Current_Password.tr,
                            hintStyle: AppTextStyle.size12Regular
                        ),
                      ),
                    ),
                    h(15),
                    Text(LocaleKeys.buttons_Re_type_New_assword.tr,style: TextStyle(),),
                    h(5),
                    Container(
                      height: Get.height*0.065,
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.00)
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: controller.RetypeNewPassword,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: LocaleKeys.buttons_Re_type_New_assword.tr,
                            hintStyle: AppTextStyle.size12Regular
                        ),
                      ),
                    ),
                    // InputTextField(
                    //   borderColor: Colors.grey,
                    //   borderRadius: 10,
                    //   hintTextStyle: TextStyle(color: Colors.grey),
                    //   context: context,
                    //   controller: controller.RetypeNewPassword,
                    //   hintText: LocaleKeys.buttons_Re_type_New_assword.tr,
                    // ),
                    h(140),
                    ButtonWithStyle(
                      onPressed: () {
                        controller.userChengpassword();
                      },
                      textVal: LocaleKeys.buttons_Update_Password.tr.toUpperCase(),
                      btnwidth: Get.width,
                    ),
                    h(15),
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey)
                        ),
                        width: Get.width,
                        height: 40,
                        child: Text(LocaleKeys.buttons_Cancel.tr.toUpperCase(),style: AppTextStyle.size14Medium.copyWith(color: Colors.black),),
                      ),
                    ),
                    h(20),
                    Container(
                        alignment: Alignment.center,
                        child: Text(LocaleKeys.buttons_Forgot_your_Password.tr.toUpperCase(),style: TextStyle(),)),
                    h(80),
                  ],
                ),
              ),
            ),
      ),
        bottomNavigationBar: btmbar(fromOther: true,),
      extendBody: true,
    );
  }
}
