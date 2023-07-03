import 'package:chopspick/app/components/cached_image_widget.dart';
import 'package:chopspick/app/components/custom_button.dart';
import 'package:chopspick/app/controllers/basket_controller.dart';
import 'package:chopspick/app/controllers/products_controller.dart';
import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:chopspick/app/models/product_model.dart';
import 'package:chopspick/core/constants/constants.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel productModel;

  ProductDetailsPage({Key? key, required this.productModel}) : super(key: key);
  final ProductController productController = Get.find();
  final BasketController basketController = Get.find();
  final UserController userController = Get.find();
  RxInt addCount = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _buildTopContainer(),
          _buildBottomContainer(),
        ],
      ),
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      height: 480.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.sp))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.0.w),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopRow(),
                SizedBox(
                  height: 10.h,
                ),
                _productNameAndButtons(),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  productModel.description!,
                  style: TextStyles.titleGreyTextStyle1(
                      color: CustomColors.greyTitleColor2, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Add Ons',
                  style: TextStyles.titleBlackTextStyle1(
                      fontWeight: FontWeight.w400, fontSize: 18.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOnsContainer(
                        child: Image.asset(Constants.healthyFood)),
                    _buildOnsContainer(
                        child: Image.asset(Constants.cheesePizza)),
                    _buildOnsContainer(
                        child: Image.asset(Constants.foodDessert)),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: CustomButton(
                    onPressed: () {
                      basketController.addProduct(productModel, addCount.value);

                      for (int i = 0;
                      i < basketController.basketItemList.length;
                      i++) {
                        debugPrint(
                            "item = ${basketController.basketItemList[i]
                                .productModel.name} count = ${basketController
                                .basketItemList[i].count}");
                      }
                      Get.back();
                    },
                    width: 329.w,
                    height: 60.h,
                    title: 'Add to Cart',
                    color: CustomColors.pinkButtomColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOnsContainer({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Stack(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
                color: CustomColors.textFormFieldFillColor,
                borderRadius: BorderRadius.circular(20.sp)),
            child: child,
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.0.h, left: 70.w),
            child: Image.asset(Constants.addButtonIcon),
          ),
        ],
      ),
    );
  }

  Row _productNameAndButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          productModel.name!,
          style: TextStyles.titleBlackTextStyle1(
              fontWeight: FontWeight.w600, fontSize: 20.sp),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  if (addCount.value > 1) {
                    addCount.value = addCount.value - 1;
                  }
                },
                icon: Image.asset(Constants.pinkDecreaseIcon)),
            Obx(
                  () => Text(addCount.value.toString()),
            ),
            IconButton(
                onPressed: () {
                  addCount.value = addCount.value + 1;
                },
                icon: Image.asset(Constants.pinkAddIcon)),
          ],
        ),
      ],
    );
  }

  Row _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 98.w,
          height: 55.h,
          decoration: BoxDecoration(
            color: CustomColors.pinkButtomColor,
            borderRadius: BorderRadius.circular(40.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(Constants.starIcon),
              Text(
                productModel.star!,
                style: TextStyles.titleWhiteTextStyle1(
                    fontWeight: FontWeight.w600, fontSize: 26.sp),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              '\$${productModel.price}',
              style: TextStyles.titleBlackTextStyle1(
                  color: CustomColors.priceYellowColor,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600),
            ),
            IconButton(
                onPressed: () {
                  productController.saveFavouritesProduct(
                      userId: userController.user.value.userId ?? '',
                      productModel: productModel);
                  // userController.user.value.userId;
                },
                icon: Icon(
                  CupertinoIcons.heart,
                  size: 28.sp,
                  color: Colors.grey,
                ))
          ],
        ),
      ],
    );
  }

  Container _buildTopContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CustomColors.detailPageLinearGradientPink,
                CustomColors.detailPageLinearGradientPurple
              ])),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 54.0.h),
            child: Image.asset(Constants.shadowElipse),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 120.0.h, horizontal: 60.w),
            child: CachedImageWidget(
              imageUrl: productModel.picture,
            ),
          ),
          Positioned(
            left: 2.w,
            top: 40,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.back,
                size: 36.sp,
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
