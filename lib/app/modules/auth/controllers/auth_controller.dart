import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/api/api_provider.dart';
import 'package:sabzee/app/modules/auth/models.dart';
import 'package:sabzee/app/modules/auth/views/login_view.dart';
import 'package:sabzee/app/modules/home/views/home_view.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Rx<bool> isLoading = true.obs;
  Rx<bool> isSignedIn = false.obs;
  SabzeeUser sabzeeUser = new SabzeeUser();
  var apiProvider = ApiProvider();

  final count = 0.obs;
  @override
  void onInit() {
    sabzeeUser.firebaseUser = auth.currentUser;
    super.onInit();
  }

  void handleAuthStateChanged(isLoggedIn) async {
    if (isLoggedIn) {
      // if not signed up on MongoDB
      // sign up on MongoDB
      // add data to mongodb


      await auth.currentUser?.getIdToken().then((token) async {
        print(token);
        var userDetails = await apiProvider.getUserDetails(token);

        Map<dynamic, dynamic> userMap =
            (userDetails.body as Map).cast<String, dynamic>();
        
        sabzeeUser.getUserData(userMap);

        if (sabzeeUser.firebaseUser == null) {
          print("saving new user");
          sabzeeUser.firebaseUser = auth.currentUser!;
        }
        Get.offAll(() => HomeView());
      });
      // .catchError((onError) {
      //   print(onError);
      // });
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
