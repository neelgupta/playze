import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/textStyle.dart';

// class InputTextField extends StatefulWidget {
//   InputTextField({
//     required this.context,
//     required this.controller,
//     this.borderColor,
//     this.borderRadius,
//     this.hintText,
//     this.hintTextStyle,
//     this.width,
//     this.cursorColor,
//     this.height,
//     this.style,
//     this.onChanged,
//   });

//   final BuildContext context;
//   final TextEditingController controller;
//   final Color? borderColor;
//   final double? borderRadius;
//   final String? hintText;
//   final TextStyle? hintTextStyle;
//   final double? width;
//   final double? height;
//   final Color? cursorColor;
//   final TextStyle? style;
//   final void Function()? onChanged;

//   @override
//   State<StatefulWidget> createState() {
//     return InputTextFieldState(
//         context: context,
//         controller: controller,
//         borderColor: borderColor,
//         borderRadius: borderRadius,
//         hintText: hintText,
//         hintTextStyle: hintTextStyle,
//         width: width,
//         height: height,
//         cursorColor: cursorColor,
//         style: style,
//         onChanged: onChanged);
//   }
// }

// class InputTextFieldState extends State<InputTextField> {
//   final BuildContext context;
//   final TextEditingController controller;
//   final Color? borderColor;
//   final double? borderRadius;
//   final String? hintText;
//   final TextStyle? hintTextStyle;
//   final double? width;
//   final double? height;
//   final Color? cursorColor;
//   final TextStyle? style;
//   final void Function()? onChanged;

//   InputTextFieldState(
//       {required this.context,
//       required this.controller,
//       this.borderColor,
//       this.borderRadius,
//       this.hintText,
//       this.hintTextStyle,
//       this.width,
//       this.height,
//       this.style,
//       this.cursorColor,
//       this.onChanged});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width ?? Get.width,
//       height: height ?? Get.height * 0.065,
//       padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
//       decoration: BoxDecoration(
//           border: Border.all(color: borderColor ?? Colors.white),
//           borderRadius: BorderRadius.circular(borderRadius ?? 5.00)),
//       child: TextFormField(
//         style: style ?? const TextStyle(color: Colors.white),
//         onChanged: (value) => onChanged != null ? onChanged!() : null,
//         controller: controller,
//         cursorColor: cursorColor ?? Colors.white,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: hintText ?? '',
//             hintStyle: hintTextStyle ?? AppTextStyle.size12Regular),
//       ),
//     );
//   }
// }

class InputTextField extends StatefulWidget {
  const InputTextField({
    super.key,
    required this.context,
    required this.controller,
    this.borderColor,
    this.borderRadius,
    this.hintText,
    this.hintTextStyle,
    this.width,
    this.validator,
    this.cursorColor,
    this.height,
    this.style,
    this.onChanged,
  });

  final BuildContext context;
  final TextEditingController controller;
  final Color? borderColor;
  final double? borderRadius;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? width;
  final double? height;
  final Color? cursorColor;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final void Function()? onChanged;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? Get.width,
      height: widget.height ?? Get.height * 0.065,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      decoration: BoxDecoration(
          border: Border.all(color: widget.borderColor ?? Colors.white),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 5.00)),
      child: TextFormField(
        style: widget.style ?? const TextStyle(color: Colors.white),
        validator: widget.validator,
        onChanged: (value) =>
            widget.onChanged != null ? widget.onChanged!() : null,
        controller: widget.controller,
        cursorColor: widget.cursorColor ?? Colors.white,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText ?? '',
            hintStyle: widget.hintTextStyle ?? AppTextStyle.size12Regular),
      ),
    );
  }
}
