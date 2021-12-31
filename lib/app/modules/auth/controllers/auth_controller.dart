import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/models.dart';
import 'package:sabzee/app/modules/auth/views/login_view.dart';
import 'package:sabzee/app/modules/home/views/home_view.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  late User? user;
  Rx<bool> isLoading = true.obs;
  Rx<bool> isSignedIn = false.obs;
  SabzeeUser sabzeeUser = new SabzeeUser();

  final count = 0.obs;
  @override
  void onInit() {
    sabzeeUser.firebaseUser = auth.currentUser;
    user = auth.currentUser;
    print(user);
    super.onInit();
  }

  void handleAuthStateChanged(isLoggedIn) async {
    if (isLoggedIn) {
      // if not signed up on MongoDB
      // sign up on MongoDB

      await auth.currentUser?.getIdToken().then((token) async {
        // bool userExists = await ApiService.doesUserExist(idToken: token);
        print("token");
        print(token);
        sabzeeUser.firebaseUser = auth.currentUser!;

        Get.offAll(() => HomeView());
      });
    } else {
      Get.offAll(() => LoginView());
    }
  }

  @override
  void onReady() async {
    ever(isSignedIn, handleAuthStateChanged);
    isSignedIn.value = await auth.currentUser != null;
    auth.authStateChanges().listen((event) {
      isSignedIn.value = event != null;
    });
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
