import 'dart:convert';

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

        Map<dynamic, dynamic> userMap =
            (userDetails.body as Map).cast<String, dynamic>();
        print("usermap");
        print(userMap.toString());
        // set data to corresponding variables
        // number, addresses, orders, defaultAddressIndex
        // if (userMap.containsKey('number'))
        sabzeeUser.number = userMap['number'];

        sabzeeUser.addresses.value =
            List<Address>.from(userMap['addresses'].map((address) {
          Map<String, String> m = {};
          m['line1'] = address['line1'];
          m['line2'] = address['line2'];
          m['street'] = address['street'];
          m['pincode'] = address['pincode'];
          m['tag'] = address['tag'];
          // print("address");
          // print(m);
          // print(m.runtimeType);
          return Address.fromJson(m);
        }));

        sabzeeUser.defaultAddressIndex.value = userMap['defaultAddressIndex'];

        sabzeeUser.orders.value =
            List<Order>.from(userMap['orders'].map((order) {
          Map<String, String> m = {};
          m['line1'] = order['line1'];
          m['line2'] = order['line2'];
          m['street'] = order['street'];
          m['pincode'] = order['pincode'];
          m['tag'] = order['tag'];
          // print("address");
          // print(m);
          // print(m.runtimeType);
          return Order.fromJson(m);
        }));

        print("payment methods: " +
            userMap['paymentMethods'].runtimeType.toString());

        sabzeeUser.paymentMethods.value = List<String>.from(
            userMap['paymentMethods'].map((paymentMethod) => paymentMethod));

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
