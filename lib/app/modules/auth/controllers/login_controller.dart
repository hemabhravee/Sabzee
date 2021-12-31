import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/home/views/home_view.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginController extends GetxController {
  //TODO: Implement LoginController
  FirebaseAuth auth = FirebaseAuth.instance;
  var currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE.obs;
  var phoneController = new TextEditingController();
  var otpController = new TextEditingController();
  late String verificationId;
  late ConfirmationResult result;
  //var user = null;
  var authController = Get.find<AuthController>();

  var showLoading = true.obs;

  verifyPhoneNumber() async {
    showLoading.value = true;
    result = await auth.signInWithPhoneNumber("+91" + phoneController.text);
    showLoading.value = false;
    currentState.value = MobileVerificationState.SHOW_OTP_FORM_STATE;
  }

  singinWithPhoneAuthcredential() async {
    //late var authCredential;
    showLoading.value = true;
    try {
      result.confirm(otpController.text).then((userCredential) =>
          authController.sabzeeUser.firebaseUser = userCredential.user);
      //  authCredential = await auth.signInWithCredential(phoneAuthCredential);
    } on Exception catch (e) {
      showLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
    showLoading.value = false;
    if (authController.sabzeeUser.firebaseUser != null)
      authController.isSignedIn.value = true;
    ;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    showLoading.toggle();
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
