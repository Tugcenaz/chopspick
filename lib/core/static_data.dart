import 'package:chopspick/app/models/food_category_model.dart';
import 'package:chopspick/core/constants/constants.dart';

List<FoodCategoryModel> categoryList = [
  FoodCategoryModel(
      foodName: 'All',
      foodId: 0,
      foodPicture: Constants.allFoodFotoUrl,
      status: 1),
  FoodCategoryModel(
      foodName: 'Burger',
      foodId: 1,
      foodPicture: Constants.burgerUrl,
      status: 1),
  FoodCategoryModel(
      foodName: 'Pizza',
      foodId: 2,
      foodPicture: Constants.pizzaUrl,
      status: 2),
  FoodCategoryModel(
      foodName: 'Dessert',
      foodId: 3,
      foodPicture: Constants.dessertUrl,
      status: 3),
];

