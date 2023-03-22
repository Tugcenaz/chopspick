import 'package:chopspick/app/controllers/products_controller.dart';
import 'package:chopspick/core/constants/constants.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductsListViewPage extends StatefulWidget {
  ProductsListViewPage({Key? key}) : super(key: key);

  @override
  State<ProductsListViewPage> createState() => _ProductsListViewPageState();
}

class _ProductsListViewPageState extends State<ProductsListViewPage> {
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productController.productList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            child: Container(
              height: 190.h,
              width: 140.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  gradient: const LinearGradient(colors: [
                    CustomColors.containerGradientColorTop,
                    CustomColors.containerGradientColorBottom
                  ])),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                          productController.productList.value[index].picture!),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        productController.productList.value[index].name!,
                        style: TextStyles.titleBlackTextStyle1(
                            fontWeight: FontWeight.w400, fontSize: 12.sp),
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0.w),
                            child: Text(
                              '\$${productController.productList.value[index].price}',
                              style: TextStyles.titleBlackTextStyle1(
                                  color: CustomColors.priceYellowColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 36.w),
                            child: IconButton(
                                onPressed: () {},
                                icon: Image.asset(Constants.addButtonIcon)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
