import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({Key? key}) : super(key: key);
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
              padding: EdgeInsets.only(left: 10,right: 10,top: 150),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: Get.width*0.4,child: Image.asset("assets/images/appIcon.png")),
                    h(20),
                    Text(LocaleKeys.text_otp_verification.tr,style: AppTextStyle.size18Medium.copyWith(letterSpacing: 1.8,fontSize: 20,fontWeight: FontWeight.w600)),
                    h(10),
                    Text("An OTP has been sent to your registered mobile number ${controller.getInitialFormattedNumber('xxx-xxx-xxxx', controller.phonenumbar ?? '')}",style: AppTextStyle.size14Medium.copyWith(letterSpacing: 1,fontWeight: FontWeight.w600)),
                    h(20),
                    Text(LocaleKeys.labels_enter.tr + " " + LocaleKeys.text_otp_here.tr,style: AppTextStyle.size14Medium.copyWith(letterSpacing: 1,fontWeight: FontWeight.w600)),
                    h(10),
                    InputTextField(
                      context: context,
                      controller: controller.otpController,
                      hintText: LocaleKeys.text_otp_here.tr,
                    ),
                    h(20),
                    GestureDetector(
                      onTap: (){

                      },
                      child: RichText(text: TextSpan(
                          children: [
                            TextSpan(text: LocaleKeys.text_didnt_receive_code.tr,style: AppTextStyle.size14Medium),
                            TextSpan(
                                text: " ${LocaleKeys.links_resend_code.tr}",
                                style: AppTextStyle.size14Medium.copyWith(color: Colors.orange,decoration: TextDecoration.underline,height: 1.5),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  controller.Rotp();
                                }
                            ),
                          ]
                      )),
                    ),
                    h(50),
                    ButtonWithStyle(
                      onPressed: () {
                        controller.otp();
                      },
                      textVal: LocaleKeys.buttons_verify.tr.toUpperCase(),
                      btnwidth: Get.width,
                    ),
                    h(30),
                  ],
                ),
              ),
            ),
      ),


    );
  }
}
