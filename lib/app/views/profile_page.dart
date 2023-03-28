
import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 34.0.w, vertical: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kullanıcı adını değiştir',
              style: TextStyles.titleBlackTextStyle1(fontSize: 18.sp),
            ),
            SizedBox(
              height: 20.h,
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
            ElevatedButton(
                onPressed: () {
                  formSubmit();
                },
                child: const Text('Güncelle')),
          ],
        ),
      ),
    );
  }
}
