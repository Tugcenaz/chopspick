import 'package:chopspick/app/models/basket_item_model.dart';
import 'package:chopspick/app/models/order_model.dart';
import 'package:chopspick/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DBService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> saveUser(UserModel userModel) async {
    try {
      await firestore
          .collection("users")
          .doc(userModel.userId.toString())
          .set(userModel.toMap());
      return true;
    } on Exception catch (e) {
      debugPrint("db error = ${e}");
      return false;
    }
  }

  Future<UserModel?> readUser(String userId) async {
    try {
      var user = await firestore.collection("users").doc(userId).get();
      UserModel userModel = UserModel.fromMap(user.data()!);
      return userModel;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      var user = await firestore
          .collection("users")
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();
      if (user.docs.isNotEmpty) {
        UserModel userModel = UserModel.fromMap(user.docs.first.data());
        return userModel;
      }
    } catch (e) {
      debugPrint("db getUSer error = $e");
    }
  }

  Future<bool?> saveOrder(
      OrderModel orderModel, List<BasketItemModel> products) async {
    try {
      var user = await firestore.collection("orders").add(orderModel.toMap());
      for (var item in products) {
        await firestore
            .collection('orders')
            .doc(user.id)
            .collection('items')
            .add(item.toMap());
      }
      return true;
    } catch (e) {
      debugPrint("db getUSer error = $e");
      return false;
    }
  }
}
