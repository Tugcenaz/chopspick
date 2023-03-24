import 'package:chopspick/app/models/basket_item_model.dart';
import 'package:chopspick/app/models/product_model.dart';
import 'package:chopspick/app/services/basket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {
  final RxList<BasketItemModel> _basketItemList = <BasketItemModel>[].obs;
  BasketService basketService = Get.find();

  List<BasketItemModel> get basketItemList => _basketItemList.value;

  set basketItemList(List<BasketItemModel> value) {
    _basketItemList.value = value;
  }

  addProduct(ProductModel product, int addCount) async {
    //ekle butonuna basınca product buraya gelecek

    ///1. durum listede hiç ürün yok (ürünü ekle)
    ///2. durum listede ürün var ama benimki yok(ürünü ekle)
    ///3. durum listede benim ürünüm zaten var (ürünü güncelle)
    ///
    ///
    if (basketItemList.isEmpty) {
      debugPrint("1. durum");
      basketItemList
          .add(BasketItemModel(productModel: product, count: addCount));
      debugPrint('item length:${basketItemList.length}');

      return true;
    } else {
      for (int i = 0; i < basketItemList.length; i++) {
        if (basketItemList[i].productModel.productId == product.productId) {
          debugPrint("3. durum");
          debugPrint("#2");
          List<BasketItemModel> basketItems = basketItemList;
          debugPrint("#3");
          basketItems[i].count = basketItems[i].count + addCount;
          debugPrint("#4");
          basketItemList = basketItems;
          debugPrint('item length:${basketItemList.length}');

          return true;
        }
      }
      debugPrint("2. durum");
      basketItemList
          .add(BasketItemModel(productModel: product, count: addCount));
      debugPrint('item length:${basketItemList.length}');
      return true;
    }
  }
}

///
/// List<Basketıtemmodel> basketItemList=[];
///
///
/// addProduct(ProductModel product){
/// - for in ile basketItemList gezilir
/// - item varsa productModeldeki count bir arttırılır
/// - item yok ise listeye eklenir
///
/// }
///
///
