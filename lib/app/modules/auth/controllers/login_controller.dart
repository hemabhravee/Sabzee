import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginController extends GetxController {
  
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
    if (phoneController.text.length != 10) {
      Get.snackbar("Invalid number", "Please enter a valid mobile number");
    } else {
      try {
        showLoading.value = true;
        result = await auth.signInWithPhoneNumber("+91" + phoneController.text);
        showLoading.value = false;
        currentState.value = MobileVerificationState.SHOW_OTP_FORM_STATE;
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  }

  singinWithPhoneAuthcredential() async {
    //late var authCredential;
    showLoading.value = true;
    try {
      result.confirm(otpController.text).then((userCredential) {
        authController.sabzeeUser.firebaseUser = userCredential.user;
        print("getting user data from authcredentials");
        print(authController.sabzeeUser.firebaseUser);
      });
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
