import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/reusability/shared/common_text_field.dart';
import 'package:playze/reusability/shared/app_text_style.dart';
import 'package:playze/reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../../../../reusability/utils/app_colors.dart';
import '../controllers/sign_in_controller.dart';

class SigninView extends GetView<SignInController> {
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
                          child: Image.asset("assets/images/appIcon.png"),
                        ),
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
                        h(15),
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
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              LocaleKeys.links_forgot_password.tr,
                              style: AppTextStyle.size14Medium
                                  .copyWith(letterSpacing: 1.5),
                            ),
                          ),
                        ),
                        h(25),
                        ButtonWithStyle(
                          onPressed: () {
                            if (controller.signInKey.currentState!.validate()) {
                              controller.signInMethod();
                            }
                            controller.update();
                          },
                          textVal: LocaleKeys.buttons_sign_in.tr,
                          btnwidth: Get.width,
                        ),
                        h(10),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
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
                                    },
                                ),
                              ],
                            ),
                          ),
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
