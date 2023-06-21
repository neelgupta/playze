import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playze/reusability/shared/app_text_style.dart';

// ignore: non_constant_identifier_names
// Util() async {
// }

TimeOfDay minutesToTimeOfDay(int minutes) {
  Duration duration = Duration(minutes: minutes);
  List<String> parts = duration.toString().split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
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
          child: Text(textVal, style: style ?? AppTextStyle.size14Medium),
        ),
      ),
    );
  }
}
