import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/textStyle.dart';

class InputTextField extends StatefulWidget {
  InputTextField(
      {required this.context,
        required this.controller,
        this.borderColor,
        this.borderRadius,
        this.hintText,
        this.hintTextStyle,
        this.width,
        this.height
      });

  final BuildContext context;
  final TextEditingController controller;
  final Color? borderColor;
  final double? borderRadius;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? width;
  final double? height;

  @override
  State<StatefulWidget> createState() {
    return InputTextFieldState(
        context: context,
        controller: controller,
      borderColor: borderColor,
      borderRadius: borderRadius,
      hintText: hintText,
      hintTextStyle: hintTextStyle,
      width : width,
        height: height
    );
  }
}

class InputTextFieldState extends State<InputTextField> {
  final BuildContext context;
  final TextEditingController controller;
  final Color? borderColor;
  final double? borderRadius;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? width;
  final double? height;

  InputTextFieldState(
      {required this.context,
        required this.controller,
        this.borderColor,
        this.borderRadius,
        this.hintText,
        this.hintTextStyle,
        this.width,
        this.height
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      height: height ?? Get.height*0.065,
      padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.white),
        borderRadius: BorderRadius.circular(borderRadius ?? 5.00)
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
          hintText: hintText ?? '',
          hintStyle: hintTextStyle ?? AppTextStyle.size12Regular
        ),
      ),
    );
  }
}