import 'package:chopspick/app/models/product_model.dart';
import 'package:get/get.dart';

class BasketItemModel {
  int count;
  ProductModel productModel;

  BasketItemModel({required this.productModel, required this.count});


  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'productModel': productModel,
    };
  }

  BasketItemModel.fromMap(Map<String, dynamic> map)
      : count = map['count'],
        productModel = map['productModel'];
}
