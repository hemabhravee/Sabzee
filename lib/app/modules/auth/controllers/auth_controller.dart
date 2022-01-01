import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/api/api_provider.dart';
import 'package:sabzee/app/modules/auth/models.dart';
import 'package:sabzee/app/modules/auth/views/login_view.dart';
import 'package:sabzee/app/modules/cart/views/add_delivery_address_view.dart';
import 'package:sabzee/app/modules/home/views/home_view.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  //late User? user;

  Rx<bool> isLoading = true.obs;
  Rx<bool> isSignedIn = false.obs;
  SabzeeUser sabzeeUser = new SabzeeUser();
  var apiProvider = ApiProvider();

  final count = 0.obs;
  @override
  void onInit() {
    sabzeeUser.firebaseUser = auth.currentUser;
    print("setting user in auth initState");
    // user = auth.currentUser;
    // print(user);
    super.onInit();
  }

  void handleAuthStateChanged(isLoggedIn) async {
    if (isLoggedIn) {
      // if not signed up on MongoDB
      // sign up on MongoDB
      // add data to mongodb
      print("fetching user details");
      //  var userDetails = await apiProvider.getSpotify();
      // print("User Details : " + userDetails.body.toString());
      // print(userDetails.statusCode);

      await auth.currentUser?.getIdToken().then((token) async {
        print(token);
        var userDetails = await apiProvider.getUserDetails(token);
        print("user details : " + userDetails.body.toString());
        print(userDetails.body.runtimeType);
        print(userDetails.body['number'].runtimeType);
        print(userDetails.body['addresses'].runtimeType);
        print(userDetails.body['orders'].runtimeType);
        print(userDetails.body['defaultAddressIndex'].runtimeType);

        // set data to corresponding variables
        // number, addresses, orders, defaultAddressIndex
        if (userDetails.body.containsKey('number'))
          sabzeeUser.number = userDetails.body['number'];

        if (userDetails.body.containsKey('addresses'))
          sabzeeUser.addresses.value = userDetails.body['addresses'];

        if (userDetails.body['orders'] != null)
          sabzeeUser.orders.value = userDetails.body['orders'];

        if (userDetails.body.containsKey('defaultAddressIndex'))
          sabzeeUser.defaultAddressIndex.value =
              userDetails.body['defaultAddressIndex'];

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
