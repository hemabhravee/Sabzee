import 'package:get/get.dart';

import 'package:sabzee/app/modules/auth/controllers/login_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
