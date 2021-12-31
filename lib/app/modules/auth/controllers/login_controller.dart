import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
  var user = null;

  var showLoading = false.obs;

  verifyPhoneNumber() async {
    showLoading.value = true;
    // auth.verifyPhoneNumber(
    //   phoneNumber: phoneController.text,
    //   verificationCompleted: (phoneAuthCredential) async {
    //     showLoading.value = true;
    //   },
    //   verificationFailed: (verificationFailed) async {
    //     showLoading.value = false;
    //     Get.snackbar(
    //       "Verification Failed",
    //       verificationFailed.message.toString(),
    //     );
    //   },
    //   codeSent: (verificationId, resendingToken) async {
    //     showLoading.value = true;
    //     currentState.value = MobileVerificationState.SHOW_OTP_FORM_STATE;
    //     this.verificationId = verificationId;
    //   },
    //   codeAutoRetrievalTimeout: (verificationId) async {},
    // );

    result = await auth.signInWithPhoneNumber(phoneController.text);
    showLoading.value = false;
    currentState.value = MobileVerificationState.SHOW_OTP_FORM_STATE;
  }

  singinWithPhoneAuthcredential() async {
    //late var authCredential;
    showLoading.value = true;
    try {
      result
          .confirm(otpController.text)
          .then((userCredential) => user = userCredential.user);
      //  authCredential = await auth.signInWithCredential(phoneAuthCredential);
    } on Exception catch (e) {
      showLoading.value = false;
      Get.snackbar("Error", "e.message.toString()");
    }
    showLoading.value = false;
    if (user != null) Get.to(() => HomeView());
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
