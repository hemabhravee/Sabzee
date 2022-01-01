import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/api/api_provider.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/auth/models.dart';

class AddDeliveryAddressController extends GetxController {
  // var nameTextController = new TextEditingController();
  // var flatNoTextController = new TextEditingController();
  // var colonyTextController = new TextEditingController();
  // var streetTextController = new TextEditingController();
  // var pincodeTextController = new TextEditingController();
  var apiProvider = new ApiProvider();
  var authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  var flatNumber = "".obs;
  var colonyName = "".obs;
  var streetName = "".obs;
  var pincode = "".obs;
  var tag = "".obs;

  onSubmit() async {
    print("address submit");
    Map<String, String> body;
    if (formKey.currentState!.validate()) {
      body = {
        "flatNumber": flatNumber.value,
        "colonyName": colonyName.value,
        "streetName": streetName.value,
        "pincode": pincode.value,
        "tag": tag.value,
      };
      print("requesting token");
      var token = await authController.sabzeeUser.firebaseUser!.getIdToken();
      print("token : " + token);

      var resp = await apiProvider.addDeliveryAddress(token: token, body: body);
      if (resp.statusCode == 201) {
        // add address to local var
        authController.sabzeeUser.addresses.add(Address.fromJson(body));
        print(authController.sabzeeUser.addresses[0]);

         Get.back();
      }
      else{
        // TODO: snackbar 
      }
    }
  }

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
}
