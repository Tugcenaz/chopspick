import 'package:chopspick/app/models/user_model.dart';
import 'package:chopspick/app/services/auth_service.dart';
import 'package:chopspick/app/services/db_service.dart';
import 'package:chopspick/app/views/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  AuthService authService = Get.find();
  DBService dbService = Get.find();
  Rx<UserModel> user = UserModel().obs;
  RxBool isUpdate = false.obs;

  registerUser(
      {required String email,
      required String password,
      required String userName}) async {
    UserModel? userModel = await authService.registerUser(
        email: email, password: password, userName: userName);
    if (userModel?.userId != null) {
      bool result = await dbService.saveUser(userModel!);
      if (result) {
        Get.offAll(() => LandingPage());
        user.value = userModel;
      }
    }
    if (user.value.userId != null) {
      debugPrint('Kayıt başarılı');
    }
  }

  currentUser() async {
    String? currentUserId = await authService.currentUser();
    //nulll
    ///current userıd yi aldım authservisten
    ///firebase dbye sorgu atıcam diyecmki şu userıdli adamı bana getir
    if (currentUserId != null) {
      UserModel? getUser = await dbService.readUser(currentUserId);
      if (getUser != null) {
        user.value = getUser;
      }
    } else {
      user.value = UserModel();
    }
    debugPrint('benim user: ${user.value.toString()}');
  }

  signOut() async {
    await authService.signOut();
    currentUser();
  }

  loginUser(
      {required String email,
      required String password,
      required String userName}) async {
    UserModel? userModel = await authService.loginUser(
        email: email, password: password, userName: userName);
    if (userModel?.userId != null) {
      Get.offAll(() => LandingPage());

      user.value = userModel!;
    }
    debugPrint('Giriş başarılı');
  }

  updateUserName({required String userName}) async {
    var uid = await authService.currentUser();
    if (uid != null) {
      var userModel = await dbService.getUser(uid);
      if (userModel != null) {
        userModel.userName = userName;
        user.value = userModel;
        dbService.saveUser(user.value);
      }
    }
  }
}
