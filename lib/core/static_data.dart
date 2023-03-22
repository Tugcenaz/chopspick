import 'package:chopspick/app/models/category_model.dart';
import 'package:chopspick/core/constants/constants.dart';

List<CategoryModel> categoryList = [
  CategoryModel(
      categoryName: 'All',
      categoryId: 0,
      categoryPicture: Constants.allFoodFotoUrl,
      status: 1),
  CategoryModel(
      categoryName: 'Burger',
      categoryId: 1,
      categoryPicture: Constants.burgerUrl,
      status: 1),
  CategoryModel(
      categoryName: 'Pizza',
      categoryId: 2,
      categoryPicture: Constants.pizzaUrl,
      status: 2),
  CategoryModel(
      categoryName: 'Dessert',
      categoryId: 3,
      categoryPicture: Constants.dessertUrl,
      status: 3),
];

