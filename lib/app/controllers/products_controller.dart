

import 'package:chopspick/app/models/food_category_model.dart';
import 'package:chopspick/app/models/product_model.dart';
import 'package:chopspick/app/services/product_service.dart';
import 'package:chopspick/core/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductService productService = Get.find();
  Rx<FoodCategoryModel> selectedCategory = categoryList.first.obs;

  ///ürünleirn listesi
  RxList<ProductModel> productList = <ProductModel>[].obs;

  selectCategory(FoodCategoryModel category) {
    selectedCategory.value = category;
    debugPrint(selectedCategory.value.toString());
  }

  saveProduct() {
    productService.saveProduct();
  }

  readProducsts( {int? categoryId}) async {
    List<ProductModel> allProductList = await productService.readProduct(categoryId: categoryId);
    if (allProductList != null) {
      productList.value = allProductList;
    }
  }

  String getCategoryNameWithId() {
    switch (selectedCategory.value.foodId) {
      case 0:
        return 'Tüm Ürünler';
      case 1:
        return 'Hamburgerler';
      case 2:
        return 'Pizzalar';
      case 3:
        return 'Tatlılar';
    }
    return '';
  }
}
