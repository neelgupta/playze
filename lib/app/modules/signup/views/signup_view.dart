import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
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
              Text(LocaleKeys.text_create_account.tr,style: AppTextStyle.size18Medium.copyWith(letterSpacing: 1.8,fontSize: 20,fontWeight: FontWeight.w600)),
              h(20),
              InputTextField(
                context: context,
                controller: controller.fNameController,
                hintText: LocaleKeys.labels_fname.tr,
              ),
              h(15),
              InputTextField(
                context: context,
                controller: controller.lNameController,
                hintText: LocaleKeys.labels_lname.tr,
              ),
              h(15),
              InputTextField(
                context: context,
                controller: controller.emailController,
                hintText: LocaleKeys.labels_email.tr,
              ),
              h(15),
              InputTextField(
                context: context,
                controller: controller.phoneController,
                hintText: LocaleKeys.labels_phone.tr,
              ),
              h(15),
              InputTextField(
                context: context,
                controller: controller.passwordController,
                hintText: LocaleKeys.labels_password.tr,
              ),
              h(15),
              InputTextField(
                context: context,
                controller: controller.cPasswordController,
                hintText: LocaleKeys.labels_confirm_password.tr,
              ),
              h(20),
              ButtonWithStyle(
                onPressed: () {
                  Get.toNamed(Routes.CHILDINFO);
                },
                textVal: LocaleKeys.buttons_next.tr.toUpperCase(),
                btnwidth: Get.width,
              ),
              h(10),
              Center(
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: LocaleKeys.text_already_have_account.tr,style: AppTextStyle.size12Medium),
                      TextSpan(
                          text: " ${LocaleKeys.buttons_log_in.tr}",
                          style: AppTextStyle.size12Medium.copyWith(color: Colors.orange,decoration: TextDecoration.underline,height: 1.5),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Get.back();
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
