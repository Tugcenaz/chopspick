import 'package:chopspick/app/components/custom_button.dart';
import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:chopspick/app/views/bottom_nav_bar.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController userController = Get.find();
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? userName;

  void formSubmit() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      userController.updateUserName(userName: userName ?? 'user');
    }
  }

  getUser() {
    var user = userController.user.value.userName;
    return user;
  }

  @override
  void initState() {
    textEditingController.text = getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.0.w, vertical: 180.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kullanıcı adını değiştir',
              style: TextStyles.titleBlackTextStyle1(fontSize: 18.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: CustomColors.textFormFieldFillColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                        20.sp,
                      ),
                    )),
                onSaved: (String? name) {
                  userName = name;
                },
                validator: (String? name) {
                  if (name != null) {
                    if (name.length > 15) {
                      return 'Kullanıcı adı 10 karakterden fazla olamaz';
                    }
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () {
                    goToPage(0);
                  },
                  title: 'İptal',
                  color: CustomColors.redButtonColor,
                  fontSize: 22.sp,
                  width: 120.w,
                  height: 40.h,
                ),
                SizedBox(
                  width: 20.w,
                ),
                CustomButton(
                  onPressed: () {
                    formSubmit();
                  },
                  title: 'Onayla',
                  color: CustomColors.greenButtonColor,
                  fontSize: 22.sp,
                  width: 120.w,
                  height: 40.h,
                ),
              ],
            ),
            SizedBox(
              height: 60.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bakiye:',
                  style: TextStyles.titleBlackTextStyle1(fontSize: 18.sp),
                ),
                Text(
                  '${userController.user.value.balance}\$',
                  style: TextStyles.titleBlackTextStyle1(fontSize: 18.sp),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Bounceable(
                onTap: () {
                  userController.signOut();
                  goToPage(0);
                },
                child: Text(
                  'Çıkış yap',
                  style: TextStyles.titleGreyTextStyle1(fontSize: 18.sp),
                )),
            SizedBox(
              height: 20.h,
            ),
            Bounceable(
                onTap: () {
                  userController.deleteUser();
                },
                child: Text(
                  'hesabı sil',
                  style: TextStyles.titleGreyTextStyle1(fontSize: 18.sp),
                )),
          ],
        ),
      ),
    );
  }
}
