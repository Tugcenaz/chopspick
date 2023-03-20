import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  Color? color;
  String? title;
  Color? titleColor;
  double? width;
  double? fontSize;
  double? height;
  Widget? child;
  double? radius;
  VoidCallback onPressed;

  CustomButton(
      {Key? key,
      this.title,
      this.color,
      this.radius,
      this.child,
      this.width,
      this.height,
      this.fontSize,
      this.titleColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(radius ?? 25.sp)),
        child: child ??
            Text(
              title!,
              style: TextStyles.titleWhiteTextStyle1(
                  fontSize: fontSize,
                  color: titleColor,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}
