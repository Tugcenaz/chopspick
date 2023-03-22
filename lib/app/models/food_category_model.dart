class FoodCategoryModel {
  String? foodPicture;
  String? foodName;
  int? foodId;
  int? status;

  @override
  String toString() {
    return 'FoodCategoryModel{foodPicture: $foodPicture, foodName: $foodName, foodId: $foodId, status: $status}';
  }

  FoodCategoryModel({this.foodName, this.foodPicture,this.foodId,this.status});
}


