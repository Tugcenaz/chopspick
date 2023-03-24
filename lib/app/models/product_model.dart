class ProductModel {
  String? name;
  int? categoryId;
  String? productId;
  String? picture;
  String? star;
  int? price;
  String? description;

  ProductModel(
      {this.name,
      this.categoryId,
      this.productId,
      this.picture,
      this.star,
      this.price,
      this.description});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': categoryId,
      'productId': productId,
      'picture': picture,
      'star': star,
      'price': price,
      'descripton': description
    };
  }

  ProductModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        categoryId = map['categoryId'],
        productId = map['productId'],
        picture = map['picture'],
        star = map['star'],
        price = map['price'],
        description = map['description'];
}
