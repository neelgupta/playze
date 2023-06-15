import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playze/Reusability/shared/lodding.dart';
import 'package:playze/Reusability/shared/textStyle.dart';

// ignore: non_constant_identifier_names
// Util() async {
// }

TimeOfDay minutesToTimeOfDay(int minutes) {
  Duration duration = Duration(minutes: minutes);
  List<String> parts = duration.toString().split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

Widget w(double count) => SizedBox(
      width: count,
    );

Widget h(double count) => SizedBox(
      height: count,
    );

TextStyle getAppFont(TextStyle textStyle) {
  return GoogleFonts.poppins(textStyle: textStyle);
}

class ButtonWithStyle extends StatelessWidget {
  final Function()? onPressed;
  final String textVal;
  final double? btnwidth;
  final TextStyle? style;
  final String? icon;
  final double? btnheight;
  final double? btnradius;
  final Color? bgColor;
  final Color? bcolor;
  final Widget? child;
  final Color? iconColor;
  final bool isDisabled;
  const ButtonWithStyle(
      {super.key,
      required this.onPressed,
      required this.textVal,
      this.btnwidth,
      this.style,
      this.btnradius,
      this.btnheight,
      this.icon,
      this.bgColor,
      this.bcolor,
      this.child,
      this.iconColor,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 40,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnradius ?? 5)),
        onPressed: onPressed ?? () {},
        color: bgColor ?? Colors.orange,
        child: Ink(
            width: btnwidth,
            height: btnheight ?? 40,
            decoration: BoxDecoration(
                border: Border.all(color: bcolor ?? Colors.orange),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child:
                    Text(textVal, style: style ?? AppTextStyle.size14Medium))));
  }
}

class UtillDialogs {
  static Future<void> showDialogBox(Widget widget, bool dismiss) {
    return Get.dialog(widget, barrierDismissible: dismiss);
  }

  static Future<void> showLoadingDialog({barrierDismissible = false}) async {
    print('opned');
    return Get.dialog(
        const Material(
          type: MaterialType.transparency,
          child: Center(
            // Aligns the container to center
            child: LoadingAni(
              isTransparent: true,
            ),
          ),
        ),
        barrierDismissible: barrierDismissible);
  }
}
