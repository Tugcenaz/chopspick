import 'package:chopspick/app/models/basket_item_model.dart';
import 'package:chopspick/app/models/product_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class BasketService {

  addProduct(ProductModel product,
      List<BasketItemModel> basketItemList)  {
    for (var element in basketItemList) {
      if (element.productModel == product) {
        var result = element.count++;
        basketItemList.remove(element);
            return BasketItemModel(productModel: product, count: result);
      } else {
        return BasketItemModel(productModel: product, count: 1);
      }
    }
  }

}