import 'package:chopspick/app/components/custom_button.dart';
import 'package:chopspick/app/views/login_page/login_page.dart';
import 'package:chopspick/core/constants/constants.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          CustomColors.introGradientPink,
          CustomColors.introGradientPurple
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(45.sp),
              height: 345.h,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Image.asset(Constants.introPageFoodPath),
            ),
            _buildRichText(
                firstText: 'Your everday ',
                secondText: 'meal',
                thirdText: 'delivered ',
                fourthText: 'to you'),
            Center(
              child: CustomButton(
                title: 'Get Started',
                width: 213.w,
                onPressed: () {
                  Get.to(() =>  LoginPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildRichText(
    {required String firstText,
    required String secondText,
    required String thirdText,
    required String fourthText}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 34.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: firstText,
            style: TextStyles.titleWhiteTextStyle1(),
            children: <TextSpan>[
              TextSpan(
                text: secondText,
                style: TextStyles.titleWhiteTextStyle1(
                    color: const Color(0xff761616),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: thirdText,
            style: TextStyles.titleWhiteTextStyle1(),
            children: <TextSpan>[
              TextSpan(
                text: fourthText,
                style: TextStyles.titleWhiteTextStyle1(
                    color: const Color(0xff761616),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
