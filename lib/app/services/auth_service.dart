import 'package:chopspick/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> registerUser(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        UserModel userModel = UserModel(
          email: credential.user!.email,
          userId: credential.user!.uid,
          createdAt:
              credential.user?.metadata.creationTime?.millisecondsSinceEpoch,
        );
        Get.snackbar('Tammmamm', 'Kayıt başarılı');
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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

  loginUser({required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      UserModel userModel = UserModel(
          email: userCredential.user!.email, userId: userCredential.user!.uid);
      Get.snackbar('Tammmamm', 'Giriş başarılı');
      return userModel;
    }
  }
}