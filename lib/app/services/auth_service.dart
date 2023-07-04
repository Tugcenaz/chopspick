import 'package:chopspick/app/components/dialogs.dart';
import 'package:chopspick/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../core/constants/service_errors.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> registerUser(
      {required String email, required String password,required String userName}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        UserModel userModel = UserModel(
          email: credential.user!.email,
          userId: credential.user!.uid,
          userName: userName,
          createdAt:
              credential.user?.metadata.creationTime?.millisecondsSinceEpoch,
        );
        Get.snackbar('Harika', 'Kayıt tamamlandı');
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      Dialogs.showErrorDialog(message: Errors.show(e.code));
    }
  }

  Future<String?> currentUser() async {
    User? user = await _firebaseAuth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  signOut() async {
    await _firebaseAuth.signOut();

  }

  Future<UserModel?> loginUser(
      {required String email, required String password,required String userName}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        UserModel userModel = UserModel(
            email: userCredential.user!.email,
            userId: userCredential.user!.uid,userName: userName);
        Get.snackbar('Harika', 'Giriş başarılı');
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      Dialogs.showErrorDialog(message: Errors.show(e.code));
    }
  }


  Future<bool?> deleteUser() async {
    await _firebaseAuth.currentUser?.delete();
    return true;
  }

}
