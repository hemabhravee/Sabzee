import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SabzeeUser {
  late User? firebaseUser;
  var addresses = [].obs;
  var defaultAddressIndex = 0.obs;
  var orders = [].obs;
}
