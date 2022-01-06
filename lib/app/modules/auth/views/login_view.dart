import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/login_controller.dart';

class LoginView extends GetView {
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    var controller = Get.find<LoginController>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('LoginView'),
      //   centerTitle: true,
      // ),
      body: Container(
        height: Get.height,
        // color: Colors.amber,
        child: Obx(
          () => Center(
            child: controller.showLoading.value
                ? CircularProgressIndicator()
                : controller.currentState.value ==
                        MobileVerificationState.SHOW_MOBILE_FORM_STATE
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: controller.phoneController,
                            decoration:
                                InputDecoration(hintText: "Phone Number"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.verifyPhoneNumber();
                            },
                            child: Text("Send OTP"),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: controller.otpController,
                            decoration: InputDecoration(hintText: "OTP"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // final phoneAuthCredential =
                              //     PhoneAuthProvider.credential(
                              //   verificationId: controller.verificationId,
                              //   smsCode: "smsCode",
                              // );
                              controller.singinWithPhoneAuthcredential();
                            },
                            child: Text("Submit OTP"),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
