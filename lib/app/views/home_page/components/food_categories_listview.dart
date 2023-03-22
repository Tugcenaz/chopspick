import 'package:chopspick/app/controllers/products_controller.dart';
import 'package:chopspick/app/models/product_model.dart';
import 'package:chopspick/core/static_data.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FoodCategoriesListViewPage extends StatefulWidget {
  FoodCategoriesListViewPage({Key? key}) : super(key: key);

  @override
  State<FoodCategoriesListViewPage> createState() =>
      _FoodCategoriesListViewPageState();
}

class _FoodCategoriesListViewPageState
    extends State<FoodCategoriesListViewPage> {
  ProductController productController = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    productController.readProducsts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildGestureDetector(
              index: index,
              child: Image.network(categoryList[index].foodPicture!));
        });
  }

  Widget _buildGestureDetector({required Widget child, required int index}) {
    return Obx(
      () => GestureDetector(
        onTap: () async {
          productController.selectCategory(categoryList[index]);
          ////urunleri getir
          if (productController.selectedCategory.value.foodId == 0) {
            QuerySnapshot<Map<String, dynamic>> allProducts =
                await firestore.collection('products').get();
            productController.productList.value = [];
            for (var element in allProducts.docs) {
              productController.productList.value
                  .add(ProductModel.fromMap(element.data()));
            }
          } else {
            var selectedProducts = await firestore
                .collection('products')
                .where('categoryId',
                    isEqualTo: productController.selectedCategory.value.foodId)
                .get();
            productController.productList.value = [];
            for (var element in selectedProducts.docs) {
              productController.productList.value
                  .add(ProductModel.fromMap(element.data()));
            }
          }
        },
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: categoryList[index].foodId ==
                          productController.selectedCategory.value.foodId
                      ? CustomColors.onTappedContainerColor
                      : CustomColors.textFormFieldFillColor,
                ),
                width: 81.w,
                height: 80.h,
                child: child),
            Text(categoryList[index].foodName ?? ""),
          ],
        ),
      ),
    );
  }
}
