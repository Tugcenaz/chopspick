import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  Color? color;
  String title;
  double? width;
  Widget? child;
  VoidCallback onPressed;

  CustomButton(
      {Key? key,
      required this.title,
      this.color,
      this.child,
      this.width,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        constraints: BoxConstraints(minHeight: 60.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(25.sp)),
        child: child ??
            Text(
              title,
              style: TextStyles.titleWhiteTextStyle1(
                  color: const Color(0xff644AB5), fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}
