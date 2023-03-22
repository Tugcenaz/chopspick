class CategoryModel {
  String? categoryPicture;
  String? categoryName;
  int? categoryId;
  int? status;

  @override
  String toString() {
    return 'FoodCategoryModel{foodPicture: $categoryPicture, foodName: $categoryName, foodId: $categoryId, status: $status}';
  }

  CategoryModel({this.categoryName, this.categoryPicture,this.categoryId,this.status});
}


