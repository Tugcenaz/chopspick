import 'package:chopspick/app/components/custom_button.dart';
import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:chopspick/core/constants/constants.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  String? email;
  String? password;
  String userName = '';
  RxBool isOnTap = true.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserController userController = Get.find();

  void formSubmit() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      debugPrint('Email:$email  şifre: $password   username: $userName');
      if (email != null && password != null) {
        userController.registerUser(
            email: email!, password: password!, userName: userName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  CustomColors.loginPageGradientPink,
                  CustomColors.loginPageGradientBlue,
                ])),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 150.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38.w),
                    child: Text(
                      'Hesap oluştur',
                      style: TextStyles.titleBlackTextStyle1(fontSize: 20.sp),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(40.0.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text('E-mail'),
                            ),
                            onSaved: (String? val) {
                              email = val;

                              for (int i = 0; i < email!.length; i++) {
                                if (email![i] != '@') {
                                  userName = userName + email![i];
                                } else {
                                  break;
                                }
                              }
                              debugPrint(userName);
                            },
                            validator: (String? value) {
                              if (value != null) {
                                bool isEmail = GetUtils.isEmail(value);
                                if (isEmail == false) {
                                  return 'Geçersiz email';
                                }
                              }
                              return null;
                            },
                          ),
                          Obx(
                            () => TextFormField(
                              obscureText: isOnTap.value,
                              onSaved: (String? val) {
                                password = val;
                              },
                              validator: (String? value) {
                                if (value!.length < 6) {
                                  return 'Şifre en az 6 karakter olmalı!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Şifre'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isOnTap.value = !isOnTap.value;
                                    debugPrint(isOnTap.value.toString());
                                  },
                                  icon: isOnTap.value == true
                                      ? Padding(
                                          padding: EdgeInsets.only(top: 10.0.h),
                                          child: SizedBox(width: 25.w,height: 25.h,
                                            child: SizedBox(
                                              width: 25.w,
                                              height: 25.h,
                                              child: SvgPicture.asset(
                                                  Constants.off_eye),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(top: 14.0.h),
                                          child: SizedBox(
                                            width: 25.w,
                                            height: 25.h,
                                            child: SvgPicture.asset(
                                                Constants.open_eye),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildContainer(),
        ],
      ),
    );
  }

  Container _buildContainer() {
    return Container(
      width: double.infinity,
      height: 485.h,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            CustomColors.loginPagePurple,
            CustomColors.loginPagePurple2
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.sp),
              topRight: Radius.circular(30.sp))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomButton(
              fontSize: 20.sp,
              title: 'Kaydol',
              onPressed: () {
                formSubmit();
              },
              color: CustomColors.signInButtonColor,
              width: 265.w,
              height: 45.h,
              radius: 10.sp,
            ),
            SizedBox(
              height: 55.h,
            ),
            Text(
              '-Şunlardan biriyle giriş yap-',
              style: TextStyles.titleBlackTextStyle1(fontSize: 15.sp),
            ),
            SizedBox(
              height: 55.h,
            ),
            CustomButton(
              onPressed: () {},
              width: 64.w,
              height: 34.h,
              radius: 10.sp,
              child: Image.asset(Constants.googleIcon),
            ),
            SizedBox(
              height: 55.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Zaten hesabın var mı? ',
                  textAlign: TextAlign.center,
                  style: TextStyles.titleBlackTextStyle1(
                      fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
                Bounceable(
                    onTap: () {
                      debugPrint('tıklandıı');
                      Get.back();
                    },
                    child: Text(
                      'Giriş yap',
                      style: TextStyles.titleWhiteTextStyle1(
                        fontSize: 18.sp,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
