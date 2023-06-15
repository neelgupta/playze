import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/shared_prefs.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../../Reusability/utils/app_colors.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: AppColors.whiteColor,
        width: 1,
      ),
    );
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: SingleChildScrollView(
          child: Form(
            key: controller.signUpKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                h(50),
                SizedBox(
                  width: Get.width * 0.4,
                  child: Image.asset("assets/images/appIcon.png"),
                ),
                h(20),
                Text(
                  LocaleKeys.text_create_account.tr,
                  style: AppTextStyle.size18Medium.copyWith(
                    letterSpacing: 1.8,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                h(20),
                InputTextField(
                  context: context,
                  controller: controller.fNameController,
                  hintText: LocaleKeys.labels_fname.tr,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                  validator: (val) {
                    if (val!.isEmpty || val == " ") {
                      return "Please Enter First Name";
                    }
                    return null;
                  },
                ),
                h(15),
                InputTextField(
                  validator: (val) {
                    if (val!.isEmpty || val == " ") {
                      return "Please Enter Last Name";
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                  context: context,
                  controller: controller.lNameController,
                  hintText: LocaleKeys.labels_lname.tr,
                ),
                h(15),
                InputTextField(
                  validator: (val) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp emailRegex = RegExp(pattern);
                    if (val!.isEmpty || val == " ") {
                      return "Please Enter Email Address";
                    } else if (!(emailRegex
                        .hasMatch(controller.emailController.text.trim()))) {
                      return "Please Enter Valid Email Address";
                    }

                    return null;
                  },
                  context: context,
                  controller: controller.emailController,
                  hintText: LocaleKeys.labels_email.tr,
                ),
                h(15),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty || val == " ") {
                      return "Please Enter Phone Number";
                    } else if (val.length < 10) {
                      return "Please Enter 10 Digits Phone Number";
                    }
                    return null;
                  },
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    errorBorder: border,
                    focusedErrorBorder: border,
                    hintText: LocaleKeys.labels_phone.tr,
                    hintStyle: AppTextStyle.size12Regular,
                  ),
                ),
                h(15),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: true,
                  controller: controller.passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    isDense: true,
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    errorBorder: border,
                    focusedErrorBorder: border,
                    hintText: LocaleKeys.labels_password.tr,
                    hintStyle: AppTextStyle.size12Regular,
                  ),
                  validator: (val) {
                    if (val!.isEmpty || val == " ") {
                      return "Please Enter Password";
                    } else if (val.length < 6) {
                      return "Password Should Be Atleast 6 Characters Long !";
                    }
                    return null;
                  },
                ),
                h(15),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty || val == " ") {
                      return "Please Enter Confirm Password";
                    } else if (val.length < 6) {
                      return "Confirm Password Should Be Atleast 6 Characters Long !";
                    } else if (val != controller.passwordController.text) {
                      return "Password And Confirm Password Does Not Match";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: controller.cPasswordController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    errorBorder: border,
                    focusedErrorBorder: border,
                    hintText: LocaleKeys.labels_confirm_password.tr,
                    hintStyle: AppTextStyle.size12Regular,
                  ),
                ),
                h(20),
                ButtonWithStyle(
                  onPressed: () {
                    if (controller.signUpKey.currentState!.validate()) {
                      SharedPrefs().value.write(SharedPrefs.fnamenKey,
                          controller.fNameController.text);
                      SharedPrefs().value.write(SharedPrefs.lnameKey,
                          controller.lNameController.text);
                      SharedPrefs().value.write(SharedPrefs.emailKey,
                          controller.emailController.text);
                      SharedPrefs().value.write(SharedPrefs.mnumbarKey,
                          controller.phoneController.text);
                      SharedPrefs().value.write(SharedPrefs.passwordKey,
                          controller.passwordController.text);
                      Get.toNamed(Routes.CHILDINFO);
                    }
                  },
                  textVal: LocaleKeys.buttons_next.tr.toUpperCase(),
                  btnwidth: Get.width,
                ),
                h(20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: LocaleKeys.text_already_have_account.tr,
                            style: AppTextStyle.size14Medium),
                        TextSpan(
                          text: " ${LocaleKeys.buttons_log_in.tr}",
                          style: AppTextStyle.size14Medium.copyWith(
                              color: Colors.orange,
                              decoration: TextDecoration.underline,
                              height: 1.5),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                h(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
