import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/app_colors.dart';

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
    this.autovalidateMode,
    this.cursorColor,
    this.tfBorderColor,
    this.height,
    this.inputFormatters,
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
  final AutovalidateMode? autovalidateMode;
  final double? height;
  final Color? cursorColor;
  final Color? tfBorderColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final void Function()? onChanged;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: widget.tfBorderColor ?? AppColors.whiteColor,
        width: 1,
      ),
    );
    return TextFormField(
      style: widget.style ?? const TextStyle(color: Colors.white),
      validator: widget.validator,
      autovalidateMode:
          widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onChanged: (value) =>
          widget.onChanged != null ? widget.onChanged!() : null,
      controller: widget.controller,
      cursorColor: widget.cursorColor ?? Colors.white,
      inputFormatters: widget.inputFormatters ?? [],
      decoration: InputDecoration(
        isDense: true,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
        hintText: widget.hintText ?? '',
        hintStyle: widget.hintTextStyle ?? AppTextStyle.size12Regular,
      ),
    );
  }
}
