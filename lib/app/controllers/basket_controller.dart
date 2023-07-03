import 'package:chopspick/app/models/basket_item_model.dart';
import 'package:chopspick/app/models/order_model.dart';
import 'package:chopspick/app/models/product_model.dart';
import 'package:chopspick/app/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {
  final RxList<BasketItemModel> _basketItemList = <BasketItemModel>[].obs;

  DBService dbService=Get.find();

  List<BasketItemModel> get basketItemList => _basketItemList.value;

  set basketItemList(List<BasketItemModel> value) {
    _basketItemList.value = value;
  }

  basketItemListRefresh() {
    List<BasketItemModel> itemList = basketItemList;
    basketItemList = [];
    basketItemList = itemList;
  }

  addProduct(ProductModel product, int addCount) async {
    //ekle butonuna basınca product buraya gelecek

    ///1. durum listede hiç ürün yok (ürünü ekle)
    ///2. durum listede ürün var ama benimki yok(ürünü ekle)
    ///3. durum listede benim ürünüm zaten var (ürünü güncelle)
    if (basketItemList.isEmpty) {
      debugPrint("1. durum");
      basketItemList = [
        ...[BasketItemModel(productModel: product, count: addCount)]
      ];
      debugPrint('item length:${basketItemList.length}');

      return true;
    } else {
      for (int i = 0; i < basketItemList.length; i++) {
        if (basketItemList[i].productModel.productId == product.productId) {
          debugPrint("3. durum");
          basketItemList[i].count = basketItemList[i].count + addCount;
          basketItemListRefresh();
          return true;
        }
      }
      basketItemList
          .add(BasketItemModel(productModel: product, count: addCount));
      basketItemListRefresh();
      return true;
    }
  }

  decreaseItem(ProductModel product,bool? isDelete) {
    for (int i = 0; i < basketItemList.length; i++) {
      if (basketItemList[i].productModel.productId == product.productId) {
        if (basketItemList[i].count == 1||isDelete==true) {
          basketItemList.remove(basketItemList[i]);
          basketItemListRefresh();
          return true;
        } else {
          basketItemList[i].count = basketItemList[i].count - 1;
          basketItemListRefresh();
          return true;
        }
      }
    }
  }

  Future<bool?> saveOrder(OrderModel orderModel,List<BasketItemModel> products)async{
    return await dbService.saveOrder(orderModel, products);
  }

  clearBasket(){
    basketItemList=[];
  }

  RxInt getItemsCount() {
    RxInt items = 0.obs;
    for (int i = 0; i < basketItemList.length; i++) {
      items.value =basketItemList[i].count + items.value;
    }
    return items;
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
