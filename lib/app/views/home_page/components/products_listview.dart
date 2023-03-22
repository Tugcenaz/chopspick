import 'package:chopspick/app/controllers/products_controller.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
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
    return Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productController.productList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            child: Container(
              padding: EdgeInsets.all(10.sp),
              height: 190.h,
              width: 140.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  gradient: const LinearGradient(colors: [
                    CustomColors.containerGradientColorTop,
                    CustomColors.containerGradientColorBottom
                  ])),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                        productController.productList.value[index].picture!),
                    Text(productController.productList.value[index].name!),
                    Row(
                      children: [
                        Text('\$${productController.productList.value[index].price}'),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
/**/
