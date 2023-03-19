import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle titleWhiteTextStyle1(
      {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(fontSize:  25.sp,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w500,
        height: 1.5,
        letterSpacing: 1.1);
  }
}