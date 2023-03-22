import 'package:chopspick/app/controllers/products_controller.dart';
import 'package:chopspick/core/static_data.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesListViewPage extends StatefulWidget {
  const CategoriesListViewPage({Key? key}) : super(key: key);

  @override
  State<CategoriesListViewPage> createState() =>
      _CategoriesListViewPageState();
}

class _CategoriesListViewPageState
    extends State<CategoriesListViewPage> {
  ProductController productController = Get.find();

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
              child: Image.network(categoryList[index].categoryPicture!));
        });
  }

  Widget _buildGestureDetector({required Widget child, required int index}) {
    return Obx(
      () => GestureDetector(
        onTap: () async {
          productController.selectCategory(categoryList[index]);
          productController.readProducsts(
              categoryId: productController.selectedCategory.value.categoryId);
          ////urunleri getir
          //tıklayınca controllerdeki ürün güncelleme fonksiyonuna istek atacak
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 34.w : 0,
            right: index == (categoryList.length - 1) ? 34.w : 0,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: index == (categoryList.length - 1) ? 0 : 12.0.w),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      color: categoryList[index].categoryId ==
                              productController.selectedCategory.value.categoryId
                          ? CustomColors.onTappedContainerColor
                          : CustomColors.textFormFieldFillColor,
                    ),
                    width: 81.w,
                    height: 80.h,
                    child: child),
              ),
              Text(categoryList[index].categoryName ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
