import 'package:chopspick/app/controllers/products_controller.dart';
import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:chopspick/app/services/db_service.dart';
import 'package:chopspick/app/views/home_page/components/categories_listview.dart';
import 'package:chopspick/app/views/home_page/components/products_listview.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final UserController userController = Get.find();
  final ProductController productController = Get.find();

  final DBService dbService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildColumn(),
    );
  }

  Widget _buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 34.0.w),
          child: Text(
            'Bugün ne sipariş etmek istiyorsun?',
            style: TextStyles.titleBlackTextStyle1(
                fontSize: 15.sp, fontWeight: FontWeight.w300),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 17.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 34.0.w),
          child: TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.sp),
                hintText: 'Search',
                hintStyle: TextStyles.titleGreyTextStyle1(),
                fillColor: CustomColors.textFormFieldFillColor,
                filled: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                  child: Image.asset(Constants.searchIcon),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30.sp))),
          ),
        ),
        SizedBox(
          height: 32.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 120.h,
          child: CategoriesListViewPage(),
        ),
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 34.0.w),
          child: Container(
            height: 180.h,
            width: double.infinity,
            color: Colors.pink,
            child: const Text(
              "promotion",
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 32.h,
          child: Obx(() => Padding(
                padding: EdgeInsets.symmetric(horizontal: 34.0.w),
                child: Text(
                  productController.getCategoryNameWithId(),
                  style: TextStyles.titleBlackTextStyle1(
                      fontSize: 23.sp, fontWeight: FontWeight.w600),
                ),
              )),
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
            height: 190.h,
            width: double.infinity,
            child: ProductsListViewPage()),
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
        child: CircleAvatar(
            backgroundImage: NetworkImage(
                userController.user.value.picture ?? Constants.profilePhoto)),
      ),
      title: Text(
        'HI, ${userController.user.value.userName}',
        style: TextStyles.titleBlackTextStyle1(fontSize: 20.sp),
      ),
      actions: [
        GestureDetector(
            onTap: () {
              userController.signOut();
            },
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
