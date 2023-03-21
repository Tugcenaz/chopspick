import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:chopspick/app/services/db_service.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final UserController userController = Get.find();
  final DBService dbService = Get.find();

  var imageSrc =
      'https://s3-alpha-sig.figma.com/img/47ca/00de/47addffa31953d37c466b1dbc9c674e3?Expires=1680480000&Signature=mavcAL4j~NVLMw8e-0K-lWbR~N4oaYBPPhdCALek17daEVB3IewpVjRKp02V7fQhCjxaJVAEFMnwxDeAU9f0xO8HV0jhwCo-9DWPfNceCml3TdaOjVbTZmmNuvAZ9kGO-z9FFw1s~CJO-dm-whV2w8pkrKmAlJp69rz6JqUZxLllNvfzUNHy~FFuvz6AdaS4VTn58EfG3rq9LqYtRDMOF6XEppfC0~ZQPzGYAp6dl6atc0FXV7HWjBveuswZQRke46Fd~vwWLBr~UXqLAxWfe5b3vR7s0mZOG2JZk7Y93MZdMKod9UF3GqE5gvwrx9q9MIeQXv-j5BUCxX5cBmHNCg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildColumn(),
    );
  }

  Column _buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bugün ne sipariş etmek istiyorsun?',
          style: TextStyles.titleBlackTextStyle1(
              fontSize: 15.sp, fontWeight: FontWeight.w300),
          textAlign: TextAlign.start,
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Search',hintStyle: TextStyles.titleGreyTextStyle1(),
              fillColor: CustomColors.textFormFieldFillColor,filled: true,
              prefixIcon: Image.asset(Constants.searchIcon),
              border: OutlineInputBorder(borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.sp))),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leading: Padding(
        padding: EdgeInsets.only(left: 30.0.w),
        child: CircleAvatar(backgroundImage: NetworkImage(imageSrc)),
      ),
      title: Text(
        'HI, ${userController.user.value.userName}',
        style: TextStyles.titleBlackTextStyle1(fontSize: 20.sp),
      ),
      actions: [
        GestureDetector(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Image.asset(
            Constants.notificationIcon,
            width: 20.w,
          ),
        )),
      ],
    );
  }
}
