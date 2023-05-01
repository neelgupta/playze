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
      body: Container(
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
                  context: context,
                  controller: controller.emailController,
                hintText: LocaleKeys.labels_email.tr,
              ),
              h(15),
              InputTextField(
                  context: context,
                  controller: controller.passwordController,
                hintText: LocaleKeys.labels_password.tr,
              ),
              h(15),
              Align(alignment: Alignment.topRight,child: Text(LocaleKeys.links_forgot_password.tr,style: AppTextStyle.size14Medium.copyWith(letterSpacing: 1.5),)),
              h(20),
              ButtonWithStyle(
                  onPressed: () {

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
    );
  }
}
