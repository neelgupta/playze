import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/modules/childinfo/views/childinfo_view.dart';
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
                onChanged: (){
                  controller.fnamestatus.value = false;
                },
                context: context,
                controller: controller.fNameController,
                hintText: LocaleKeys.labels_fname.tr,
              ),
              Obx(() => controller.fnamestatus.value?SizedBox(
                child: Text(controller.status,style: TextStyle(color: Colors.red),),
              ):Container(),),
              h(15),
              InputTextField(
                onChanged: (){
                  controller.lnamestatus.value = false;
                },
                context: context,
                controller: controller.lNameController,
                hintText: LocaleKeys.labels_lname.tr,
              ),
              Obx(() => controller.lnamestatus.value?SizedBox(
               child: Text(controller.status,style: TextStyle(color: Colors.red),),
             ):Container(),) ,
              h(15),
              InputTextField(
                onChanged: (){
                  controller.emailstatus.value = false;
                },
                context: context,
                controller: controller.emailController,
                hintText: LocaleKeys.labels_email.tr,
              ),
              Obx(() => controller.emailstatus.value?SizedBox(
                child: Text(controller.status,style: TextStyle(color: Colors.red),),
              ):Container(),),
              h(15),
              InputTextField(
                onChanged: (){
                  controller.phonestatus.value = false;
                },
                context: context,
                controller: controller.phoneController,
                hintText: LocaleKeys.labels_phone.tr,
              ),
              Obx(() => controller.phonestatus.value?SizedBox(
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
                  obscureText: true,
                  controller: controller.passwordController,
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
              Container(
                height: Get.height*0.065,
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5.00)
                ),
                child: TextFormField(
                  onChanged: (value) => (){
                    controller.cPasswordstatus.value = false;
                  },
                  obscureText: true,
                  controller: controller.cPasswordController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: LocaleKeys.labels_confirm_password.tr,
                      hintStyle: AppTextStyle.size12Regular
                  ),
                ),
              ),
              Obx(() => controller.cPasswordstatus.value?SizedBox(
                child: Text(controller.status,style: TextStyle(color: Colors.red),),
              ):Container(),),
              h(20),
              ButtonWithStyle(
                onPressed: () {
                  bool contactValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(controller.phoneController.text);
                  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(controller.emailController.text);
                  if(controller.fNameController.text.isEmpty){
                    controller.fnamestatus.value = true;
                    controller.status = "please enter FristName";
                  }else if(controller.lNameController.text.isEmpty){
                    controller.lnamestatus.value = true;
                    controller.status = "please enter LastName";
                  }else if(controller.emailController.text.isEmpty){
                    controller.emailstatus.value = true;
                    controller.status = "please enter email";
                  }else if(!emailValid){
                      controller.emailstatus.value = true;
                      controller.status = "please enter valid email";
                  } else if(controller.phoneController.text.isEmpty){
                    controller.phonestatus.value = true;
                    controller.status = "please enter PhoneNumber";
                  }else if(!contactValid){
                    controller.phonestatus.value = true;
                    controller.status = "please enter valid PhoneNumber";
                  }else if(controller.passwordController.text.isEmpty){
                    controller.passwordstatus.value = true;
                    controller.status = "please enter Password";
                  }else if(controller.passwordController.text.length <= 6){
                    controller.passwordstatus.value = true;
                    controller.status = "please enter Six charter";
                  }else if(controller.cPasswordController.text.isEmpty){
                    controller.cPasswordstatus.value = true;
                    controller.status = "please enter ConfrimPassword";
                  }else if(controller.passwordController.text != controller.cPasswordController.text){
                    controller.cPasswordstatus.value = true;
                    controller.status = "Password Not Mech..";
                  }
                  else{
                    SharedPrefs().value.write(SharedPrefs.fnamenKey,controller.fNameController.text);
                    SharedPrefs().value.write(SharedPrefs.lnameKey,controller.lNameController.text);
                    SharedPrefs().value.write(SharedPrefs.emailKey,controller.emailController.text);
                    SharedPrefs().value.write(SharedPrefs.mnumbarKey,controller.phoneController.text);
                    SharedPrefs().value.write(SharedPrefs.passwordKey,controller.passwordController.text);
                    Get.toNamed(Routes.CHILDINFO);
                  }
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
