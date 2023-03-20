import 'package:chopspick/app/controllers/user_controller.dart';
import 'package:chopspick/app/services/db_service.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    //services
    Get.lazyPut(() => AuthService(), fenix: true);
    Get.lazyPut(() => DBService(), fenix: true);



    Get.lazyPut(() => UserController(), fenix: true);
  }
}
