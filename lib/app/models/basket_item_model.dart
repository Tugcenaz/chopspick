import 'package:chopspick/app/models/product_model.dart';

class BasketItemModel {
  int count;
  ProductModel productModel;

  BasketItemModel({required this.productModel,required this.count});


  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'productModel': productModel.toMap(),
    };
  }

  BasketItemModel.fromMap(Map<String, dynamic> map)
      : count = map['count'],
        productModel = map['productModel'];
}
