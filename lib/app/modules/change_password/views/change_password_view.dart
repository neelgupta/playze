import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/reusability/shared/custom_bottom_bar.dart';
import 'package:playze/reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../../reusability/shared/app_text_style.dart';
import '../../../../reusability/shared/common_text_field.dart';
import '../../../../reusability/utils/app_colors.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var bodrer = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(6),
      ),
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1, //
        flexibleSpace: Container(
          height: Get.height * 0.2,
          color: const Color(0xff0264C5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: Get.height * 0.06,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              child: const Image(
                                image: AssetImage("assets/images/back.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.buttons_Change_Password.tr,
                            style: const TextStyle(
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
                margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.buttons_Current_Password.tr,
                          style: const TextStyle(),
                        ),
                        h(5),
                        TextFormField(
                          obscureText: true,
                          controller: controller.currentPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty || value == " ") {
                              return "Please Enter Current Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: bodrer,
                            enabledBorder: bodrer,
                            focusedBorder: bodrer,
                            hintText: LocaleKeys.buttons_Current_Password.tr,
                            hintStyle: AppTextStyle.size12Regular
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                        // InputTextField(
                        //   borderColor: Colors.grey,
                        //   borderRadius: 10,
                        //   hintTextStyle: TextStyle(color: Colors.grey),
                        //   context: context,
                        //   controller: controller.currentPassword,
                        //   hintText: LocaleKeys.buttons_Current_Password.tr,
                        // ),
                        h(15),
                        Text(
                          LocaleKeys.buttons_New_Password.tr,
                          style: const TextStyle(),
                        ),
                        h(5),
                        TextFormField(
                          obscureText: true,
                          controller: controller.newPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty || value == " ") {
                              return "Please Enter New Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: bodrer,
                              enabledBorder: bodrer,
                              focusedBorder: bodrer,
                              hintText: LocaleKeys.buttons_New_Password.tr,
                              hintStyle: AppTextStyle.size12Regular
                                  .copyWith(color: Colors.grey)),
                        ),
                        h(15),
                        Text(
                          LocaleKeys.buttons_Re_type_New_assword.tr,
                        ),
                        h(5),
                        TextFormField(
                          obscureText: true,
                          controller: controller.retypeNewPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty || value == " ") {
                              return "Please Enter Current Password";
                            } else if (value != controller.newPassword.text) {
                              return "New Password and Retype New Password not match.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: bodrer,
                              enabledBorder: bodrer,
                              focusedBorder: bodrer,
                              hintText:
                                  LocaleKeys.buttons_Re_type_New_assword.tr,
                              hintStyle: AppTextStyle.size12Regular
                                  .copyWith(color: Colors.grey)),
                        ),
                        // InputTextField(
                        //   borderColor: Colors.grey,
                        //   borderRadius: 10,
                        //   hintTextStyle: TextStyle(color: Colors.grey),
                        //   context: context,
                        //   controller: controller.retypenewPassword,
                        //   hintText: LocaleKeys.buttons_Re_type_New_assword.tr,
                        // ),
                        h(140),
                        ButtonWithStyle(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.userChangePassword();
                            }
                          },
                          textVal: LocaleKeys.buttons_Update_Password.tr
                              .toUpperCase(),
                          btnwidth: Get.width,
                        ),
                        h(15),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            width: Get.width,
                            height: 40,
                            child: Text(
                              LocaleKeys.buttons_Cancel.tr.toUpperCase(),
                              style: AppTextStyle.size14Medium
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        h(20),
                        GestureDetector(
                          onTap: () {
                            Get.dialog(
                              Material(
                                type: MaterialType.transparency,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              width: Get.size.width * 0.88,
                                              height: 260,
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Form(
                                                key: controller
                                                    .forgotPassFormKey,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Forgot Password",
                                                      style: AppTextStyle
                                                          .size18Medium
                                                          .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    h(30),
                                                    InputTextField(
                                                      context: context,
                                                      controller: controller
                                                          .forgotPassController,
                                                      hintText: LocaleKeys
                                                          .labels_email.tr,
                                                      validator: (val) {
                                                        String pattern =
                                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                        RegExp emailRegex =
                                                            RegExp(pattern);
                                                        if (val!.isEmpty ||
                                                            val == " ") {
                                                          return "Please Enter Email Address";
                                                        } else if (!(emailRegex
                                                            .hasMatch(
                                                                val.trim()))) {
                                                          return "Please Enter Valid Email Address";
                                                        }

                                                        return null;
                                                      },
                                                    ),
                                                    h(10),
                                                    const Spacer(),
                                                    Obx(() => controller
                                                            .isForgotLoading
                                                            .value
                                                        ? const CircularProgressIndicator(
                                                            color: AppColors
                                                                .whiteColor,
                                                          )
                                                        : ButtonWithStyle(
                                                            onPressed: () {
                                                              if (controller
                                                                  .forgotPassFormKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                controller
                                                                    .forgotPasswordFunction();
                                                              }
                                                            },
                                                            textVal: "Send"
                                                                .toUpperCase(),
                                                            btnwidth: Get.width,
                                                          )),
                                                    h(10),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 80)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                LocaleKeys.buttons_Forgot_your_Password.tr
                                    .toUpperCase(),
                                style: const TextStyle(),
                              )),
                        ),
                        h(80),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const CustomBottomBar(
        fromOther: true,
      ),
      extendBody: true,
    );
  }
}
