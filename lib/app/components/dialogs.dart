import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Dialogs {
  static showErrorDialog({required String message}) {
    Get.defaultDialog(
        title: "Hata",
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyles.titleBlackTextStyle1(fontSize: 14.sp),
        ),
        textCancel: "Kapat",
        cancelTextColor: CustomColors.primaryColor,
        buttonColor: CustomColors.primaryColor);
  }

  static showSuccesDialog({required String message}) {
    Get.defaultDialog(
        title: "Başarılı",
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyles.titleBlackTextStyle1(fontSize: 14.sp),
        ),
        textCancel: "Kapat",
        cancelTextColor: CustomColors.primaryColor,
        buttonColor: CustomColors.primaryColor);
  }
}
