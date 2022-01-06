import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/api/api_provider.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/auth/models.dart';

class AddDeliveryAddressController extends GetxController {
  Map<String, String> args = Get.arguments ?? <String, String>{};
  var line1TextController = new TextEditingController();
  var line2TextController = new TextEditingController();
  var streetTextController = new TextEditingController();
  var cityTextController = new TextEditingController();
  var tagTextController = new TextEditingController();
  var pincodeTextController = new TextEditingController();
  var apiProvider = new ApiProvider();
  var authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  RxString oldTag = "".obs;

  onSubmit() async {
    print("address submit");
    Map<String, String> body;
    if (formKey.currentState!.validate()) {
      body = {
        "line1": line1TextController.text,
        "line2": line2TextController.text,
        "street": streetTextController.text,
        "pincode": pincodeTextController.text,
        "tag": tagTextController.text,
        "city": "Ranchi"
      };
      print(body);
      print("requesting token");
      var token = await authController.sabzeeUser.firebaseUser!.getIdToken();
      print("token : " + token);
      if (oldTag == "") {
        var resp =
            await apiProvider.addDeliveryAddress(token: token, body: body);
        if (resp.statusCode == 201) {
          // add address to local var
          authController.sabzeeUser.addresses.add(Address.fromJson(body));
          print(authController.sabzeeUser.addresses[0]);

          Get.back();
        } else {
          // TODO: snackbar
        }
      } else {
        var resp = await apiProvider.editDeliveryAddress(
            token: token, body: body, tag: oldTag.value);
        if (resp.statusCode == 202) {
          // add address to local var
          int i =
              authController.sabzeeUser.getAddressIndexFromTag(oldTag.value);
          print("index : $i");
          authController.sabzeeUser.addresses.value[i] = Address.fromJson(body);
          print(authController.sabzeeUser.addresses[i]);
          authController.sabzeeUser.addresses.refresh();

          Get.back();
        } else {
          // TODO: snackbar
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    //if (x.keyExists('oldTag')) oldTag = x['oldTag'];
    //for (var key in x) print(key);
    cityTextController.text = "Ranchi";
    print("arguments : " + args.toString());

    oldTag.value = args.containsKey("oldTag") ? args['oldTag']! : "";
    print("oldTag : " + oldTag.value);
    if (oldTag != "") {
      print("OLDtAG EXISTS");
      int i = authController.sabzeeUser.getAddressIndexFromTag(oldTag.value);
      line1TextController.text = authController.sabzeeUser.addresses[i].line1;
      line2TextController.text = authController.sabzeeUser.addresses[i].line2;
      streetTextController.text = authController.sabzeeUser.addresses[i].street;
      pincodeTextController.text =
          authController.sabzeeUser.addresses[i].pincode;
      tagTextController.text = authController.sabzeeUser.addresses[i].tag;
    }
    super.onReady();
  }

  @override
  void onClose() {}
}
