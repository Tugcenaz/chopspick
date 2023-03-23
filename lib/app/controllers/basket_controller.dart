import 'package:chopspick/app/models/basket_item_model.dart';
import 'package:chopspick/app/models/product_model.dart';
import 'package:chopspick/app/services/basket_service.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {
  RxList<BasketItemModel> basketItemList = <BasketItemModel>[].obs;
  BasketService basketService = Get.find();

  addProduct(ProductModel product) async{
    //ekle butonuna basınca product buraya gelecek

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
