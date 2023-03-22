class ProductModel {
  String? name;
  int? categoryId;
  String? picture;
  String? star;
  int? count;
  int? price;
  String? description;

  ProductModel(
      {this.name,
      this.categoryId,
      this.picture,
      this.star,
      this.count = 1,
      this.price,
      this.description});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': categoryId,
      'picture': picture,
      'star': star,
      'count': count,
      'price': price,
      'descripton': description
    };
  }

  ProductModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        categoryId = map['categoryId'],
        picture = map['picture'],
        star = map['star'],
        count = map['count'],
        price = map['price'],
        description = map['description'];
}
