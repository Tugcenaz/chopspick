import 'package:chopspick/app/models/basket_item_model.dart';
import 'package:chopspick/app/models/product_model.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {
  RxList<BasketItemModel> basketItemList = <BasketItemModel>[].obs;

  addProduct(ProductModel product) {
    //ekle butonuna basınca product buraya gelecek
    for (var element in basketItemList) {
      if (element.productModel == product) {
        element.count++;
      } else {
        basketItemList.add(BasketItemModel(productModel: product, count: 1));
      }
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
