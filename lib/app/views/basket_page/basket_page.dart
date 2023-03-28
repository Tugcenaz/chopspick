import 'package:chopspick/app/components/cached_image_widget.dart';
import 'package:chopspick/app/controllers/basket_controller.dart';
import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:chopspick/app/models/order_model.dart';
import 'package:chopspick/app/views/bottom_nav_bar.dart';
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
  UserController userController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();
  String? orderNote;

  RxInt count = 1.obs;

  RxBool busy = false.obs;

  int getCost() {
    int cost = 0;
    for (int i = 0; i < basketController.basketItemList.length; i++) {
      var count = basketController.basketItemList[i].count;
      for (int j = 0; j < count; j++) {
        // debugPrint("tuğçenin döngüsü");
        cost = basketController.basketItemList[i].productModel.price! + cost;
      }
    }
    return cost;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 51.0.h, horizontal: 31.w),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    '${basketController.getItemsCount().toString()} items in Cart',
                    style: TextStyles.titleBlackTextStyle1(
                        fontSize: 26.sp, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
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
                                itemCount:
                                    basketController.basketItemList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  debugPrint(
                                      "itemlist length = ${basketController.basketItemList.length}");
                                  return _buildBasketItemsContainer(index);
                                }),
                          ),
                  ),
                ),
                const Text('Order Instructions'),
                TextFormField(
                  controller: _textEditingController,
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                  onChanged: (String? note) {
                    orderNote = note;
                    debugPrint(orderNote);
                  },
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
                    Obx(
                      () => Text(
                        '\$ ${getCost()}',
                        style: TextStyles.titleWhiteTextStyle1(
                            fontWeight: FontWeight.w600,
                            fontSize: 26.sp,
                            color: CustomColors.priceYellowColor),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: CustomButton(
                    onPressed: () async {
                      if (basketController.basketItemList.isNotEmpty) {
                        if (busy.value == false) {
                          try {
                            busy.value = true;
                            bool? result = await basketController.saveOrder(
                                OrderModel(
                                    userId:
                                        userController.user.value.userId ?? "",
                                    totalPrice: getCost(),
                                    orderNote: orderNote),
                                basketController.basketItemList);
                            if (result == true) {
                              await Future.delayed(const Duration(seconds: 3));
                              basketController.clearBasket();
                              _textEditingController.text = '';
                            }
                          } finally {
                            busy.value = false;
                          }
                        }
                      } else {
                        Get.snackbar('Hata', 'Sepetin boş');
                      }
                    },
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
                    onTap: () {
                      goToPage(0);
                    },
                  ),
                ),
              ],
            ),
            Obx(
              () => busy.value == true
                  ? const CircularProgressIndicator()
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasketItemsContainer(int index) {
    String? imageUrl =
        basketController.basketItemList[index].productModel.picture;
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        child: Row(
          children: [
            Container(
              width: 121.w,
              height: 129.h,
              decoration: BoxDecoration(
                  color: CustomColors.containerGradientColorTop,
                  borderRadius: BorderRadius.circular(20.sp)),
              child: CachedImageWidget(
                imageUrl: imageUrl,
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
                  child: Row(
                    children: [
                      Text(
                        basketController
                            .basketItemList[index].productModel.name!,
                        style: TextStyles.titleBlackTextStyle1(
                          fontSize: 16.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24.0.w),
                        child: Bounceable(
                          onTap: () {
                            basketController.decreaseItem(
                                basketController
                                    .basketItemList[index].productModel,
                                true);
                          },
                          child: Image.asset(Constants.deleteIcon),
                        ),
                      ),
                    ],
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
                          onPressed: () {
                            basketController.decreaseItem(
                                basketController
                                    .basketItemList[index].productModel,
                                false);
                          },
                          icon: Image.asset(Constants.pinkDecreaseIcon)),
                      Text(basketController.basketItemList[index].count
                          .toString()),
                      IconButton(
                          onPressed: () {
                            basketController.addProduct(
                                basketController
                                    .basketItemList[index].productModel,
                                1);
                          },
                          icon: Image.asset(Constants.pinkAddIcon)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
