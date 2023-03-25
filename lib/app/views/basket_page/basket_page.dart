import 'package:chopspick/app/controllers/basket_controller.dart';
import 'package:chopspick/core/constants/constants.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/custom_button.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  BasketController basketController = Get.find();

  RxInt count = 1.obs;

  RxInt getItemsCount() {
    RxInt items = 0.obs;
    for (int i = 0; i < basketController.basketItemList.length; i++) {
      items.value = basketController.basketItemList[i].count + items.value;
    }
    return items;
  }

  int getCost() {
    int cost = 0;
    for (int i = 0; i < basketController.basketItemList.length; i++) {
      var count = basketController.basketItemList[i].count;
      for (int j = 0; j < count; count++) {
        cost = basketController.basketItemList[i].productModel.price! + cost;
      }
    }

    return cost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 63.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                '${getItemsCount().toString()} items in Cart',
                style: TextStyles.titleBlackTextStyle1(
                    fontSize: 26.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Obx(
              () => Expanded(
                child: basketController.basketItemList.isEmpty
                    ? Text(
                        'Sepetnize henüz ürün eklemediniz',
                        style: TextStyles.titleBlackTextStyle1(
                            fontSize: 20.sp, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      )
                    : Obx(
                        () => ListView.builder(
                            itemCount: basketController.basketItemList.length,
                            itemBuilder: (BuildContext context, int index) {
                              debugPrint(
                                  "itemlist length = ${basketController.basketItemList.length}");
                              return _buildBasketItemsContainer(index);
                            }),
                      ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            const Text('Order Instructions'),
            TextFormField(
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyles.titleBlackTextStyle1(fontSize: 23.sp),
                ),
                Text(
                  '\$fiyat yazacak',
                  style: TextStyles.titleWhiteTextStyle1(
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                      color: CustomColors.priceYellowColor),
                ),
              ],
            ),
            Center(
              child: CustomButton(
                onPressed: () {},
                width: 349.w,
                height: 60.h,
                title: 'Checkout',
                color: CustomColors.pinkButtomColor,
              ),
            ),
            Center(
              child: Bounceable(
                child: Text(
                  'Back to Menu',
                  style: TextStyles.titleBlackTextStyle1(
                      fontWeight: FontWeight.w600, fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasketItemsContainer(int index) {
    return Obx(
      () => Row(
        children: [
          Container(
            width: 121.w,
            height: 129.h,
            decoration: BoxDecoration(
                color: CustomColors.containerGradientColorTop,
                borderRadius: BorderRadius.circular(20.sp)),
            child: Image.network(
              basketController.basketItemList[index].productModel.picture!,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0.w),
                child: Text(
                  basketController.basketItemList[index].productModel.name!,
                  style: TextStyles.titleBlackTextStyle1(
                    fontSize: 20.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0.w),
                child: Text(
                  '\$${basketController.basketItemList[index].productModel.price}',
                  style: TextStyles.titleWhiteTextStyle1(
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                      color: CustomColors.priceYellowColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(Constants.pinkDecreaseIcon)),
                    Text(basketController.basketItemList[index].count
                        .toString()),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(Constants.pinkAddIcon)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}