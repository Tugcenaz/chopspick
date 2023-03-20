import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Bounceable(
              onTap: () {
                userController.signOut();
              },
              child: Text("Home Page"))),
    );
  }
}
