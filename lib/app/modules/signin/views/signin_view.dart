import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : Container(
              height: Get.height,
              width: Get.width,
              alignment: Alignment.center,
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: Get.width*0.4,child: Image.asset("assets/images/appIcon.png")),
                    h(20),
                    Text(LocaleKeys.buttons_sign_in.tr,style: AppTextStyle.size18Medium.copyWith(color: Colors.white,fontWeight: FontWeight.w600)),
                    h(20),
                    InputTextField(
                      onChanged: (){
                        controller.emailstatus.value = false;
                      },
                      style: const TextStyle(color: Colors.white),
                      context: context,
                      controller: controller.emailController,
                      hintText: LocaleKeys.labels_email.tr,
                    ),
                    Obx(() => controller.emailstatus.value?SizedBox(
                      child: Text(controller.status,style: TextStyle(color: Colors.red),),
                    ):Container(),),
                    h(15),
                    Container(
                      height: Get.height*0.065,
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5.00)
                      ),
                      child: TextFormField(
                        onChanged: (value) => (){
                          controller.passwordstatus.value = false;
                        },
                        style: const TextStyle(color: Colors.white),
                        obscureText: true,
                        controller: controller.passwordController,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: LocaleKeys.labels_password.tr,
                            hintStyle: AppTextStyle.size12Regular
                        ),
                      ),
                    ),
                    Obx(() => controller.passwordstatus.value?SizedBox(
                      child: Text(controller.status,style: TextStyle(color: Colors.red),),
                    ):Container(),),
                    h(15),
                    GestureDetector(
                        onTap: (){
                          Get.dialog(
                            Material(
                              type: MaterialType.transparency,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(20))),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(Radius.circular(20))
                                            ),
                                              width: 300,
                                              height: 240,
                                              padding: EdgeInsets.all(24.0),
                                            child: Column(
                                              children: [
                                                Text("Forgot Password",style: AppTextStyle.size18Medium.copyWith(color: Colors.white,fontWeight: FontWeight.w600)),
                                                h(30),
                                                InputTextField(
                                                  onChanged: (){
                                                    controller.emailstatus.value = false;
                                                  },
                                                  context: context,
                                                  controller: controller.emailController,
                                                  hintText: LocaleKeys.labels_email.tr,
                                                ),
                                                h(10),
                                                Spacer(),
                                                ButtonWithStyle(
                                                  onPressed: () {

                                                  },
                                                  textVal: "Send".toUpperCase(),
                                                  btnwidth: Get.width,
                                                ),
                                                h(10),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Align(alignment: Alignment.topRight,child: Text(LocaleKeys.links_forgot_password.tr,style: AppTextStyle.size14Medium.copyWith(letterSpacing: 1.5),))),
                    h(20),
                    ButtonWithStyle(
                      onPressed: () {
                        if(controller.emailController.text.isEmpty){
                          controller.emailstatus.value = true;
                          controller.status = "Please Enter Email";
                        }else if(controller.passwordController.text.isEmpty){
                          controller.passwordstatus.value = true;
                          controller.status = "Please Enter Password";
                        }
                        else{
                          controller.signin();
                        }
                      },
                      textVal: LocaleKeys.buttons_sign_in.tr.toUpperCase(),
                      btnwidth: Get.width,
                    ),
                    h(10),
                    Center(
                      child: RichText(text: TextSpan(
                          children: [
                            TextSpan(text: LocaleKeys.text_dont_have_account.tr,style: AppTextStyle.size12Medium),
                            TextSpan(
                                text: " ${LocaleKeys.buttons_sign_up.tr}",
                                style: AppTextStyle.size12Medium.copyWith(color: Colors.orange,decoration: TextDecoration.underline,height: 1.5),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Get.toNamed(Routes.SIGNUP);
                                }
                            ),
                          ]
                      )),
                    ),
                  ],
                ),
              ),
            ),
      ),


    );
  }
}
