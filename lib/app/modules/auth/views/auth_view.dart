import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(), permanent: true);
    var controller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('AuthView'),
        centerTitle: true,
      ),
      body: Center(
        child: controller.isLoading.value
            ? CircularProgressIndicator()
            : controller.sabzeeUser.firebaseUser == null
                ? Container()
                : Container(),
      ),
    );
  }
}
