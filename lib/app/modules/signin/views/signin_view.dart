import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../../Reusability/utils/app_colors.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
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
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.signInKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: Get.width * 0.4,
                            child: Image.asset("assets/images/appIcon.png")),
                        h(20),
                        Text(
                          LocaleKeys.buttons_sign_in.tr,
                          style: AppTextStyle.size18Medium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        h(20),
                        InputTextField(
                          style: const TextStyle(color: Colors.white),
                          context: context,
                          controller: controller.emailController,
                          hintText: LocaleKeys.labels_email.tr,
                          validator: (val) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp emailRegex = RegExp(pattern);
                            if (val!.isEmpty || val == " ") {
                              return "Please Enter Email Address";
                            } else if (!(emailRegex.hasMatch(
                                controller.emailController.text.trim()))) {
                              return "Please Enter Valid Email Address";
                            }

                            return null;
                          },
                        ),
                        // h(10),
                        // Obx(
                        //   () => controller.emailstatus.value
                        //       ? SizedBox(
                        //           child: Text(
                        //             controller.status,
                        //             style: const TextStyle(color: Colors.red),
                        //           ),
                        //         )
                        //       : Container(),
                        // ),
                        h(15),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          controller: controller.passwordController,
                          cursorColor: Colors.white,
                          validator: (val) {
                            if (val!.isEmpty || val == " ") {
                              return "Please Enter Password";
                            } else if (val.length < 6) {
                              return "Password Should Be Atleast 6 Characters Long !";
                            }
                            return null;
                          },
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
                        ),
                        // h(10),
                        // Obx(
                        //   () => controller.passwordstatus.value
                        //       ? SizedBox(
                        //           child: Text(
                        //             controller.status,
                        //             style: const TextStyle(color: Colors.red),
                        //           ),
                        //         )
                        //       : Container(),
                        // ),
                        h(20),
                        GestureDetector(
                            onTap: () {
                              Get.dialog(
                                Material(
                                  type: MaterialType.transparency,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                width: Get.size.width * 0.88,
                                                height: 240,
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
                                                          if (val!.isEmpty ||
                                                              val == " ") {
                                                            return "Please Enter Email Address";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      h(10),
                                                      const Spacer(),
                                                      ButtonWithStyle(
                                                        onPressed: () {
                                                          if (controller
                                                              .forgotPassFormKey
                                                              .currentState!
                                                              .validate()) {
                                                            // controller.forgotPasswordApi();
                                                          }
                                                        },
                                                        textVal: "Send"
                                                            .toUpperCase(),
                                                        btnwidth: Get.width,
                                                      ),
                                                      h(10),
                                                    ],
                                                  ),
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
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  LocaleKeys.links_forgot_password.tr,
                                  style: AppTextStyle.size14Medium
                                      .copyWith(letterSpacing: 1.5),
                                ))),
                        h(20),
                        ButtonWithStyle(
                          onPressed: () {
                            // String pattern =
                            //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            // RegExp emailRegex = RegExp(pattern);
                            // if (controller.emailController.text.isEmpty) {
                            //   controller.emailstatus.value = true;

                            //   // if (!(emailRegex.hasMatch(
                            //   //     controller.emailController.text.trim()))) {
                            //   //   controller.status = "Email Address is invalid ";
                            //   // } else {
                            //   controller.status = "Please Enter Email";
                            //   // }
                            // } else if (!(emailRegex.hasMatch(
                            //     controller.emailController.text.trim()))) {
                            //   controller.emailstatus.value = true;
                            //   log("Email Address is invalid ");
                            //   controller.status = "Email Address is invalid.";
                            // } else if (controller
                            //     .passwordController.text.isEmpty) {
                            //   controller.passwordstatus.value = true;
                            //   controller.status = "Please Enter Password";
                            // } else {
                            //   controller.signin();
                            // }
                            if (controller.signInKey.currentState!.validate()) {
                              controller.signin();
                            }
                            controller.update();
                          },
                          textVal: LocaleKeys.buttons_sign_in.tr.toUpperCase(),
                          btnwidth: Get.width,
                        ),
                        h(10),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: LocaleKeys.text_dont_have_account.tr,
                                style: AppTextStyle.size12Medium),
                            TextSpan(
                                text: " ${LocaleKeys.buttons_sign_up.tr}",
                                style: AppTextStyle.size12Medium.copyWith(
                                    color: Colors.orange,
                                    decoration: TextDecoration.underline,
                                    height: 1.5),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(Routes.SIGNUP);
                                  }),
                          ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
