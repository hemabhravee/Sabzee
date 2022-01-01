import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/api/api_provider.dart';

class AddDeliveryAddressController extends GetxController {
  // var nameTextController = new TextEditingController();
  // var flatNoTextController = new TextEditingController();
  // var colonyTextController = new TextEditingController();
  // var streetTextController = new TextEditingController();
  // var pincodeTextController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  var recipientName = "".obs;
  var flatNumber = "".obs;
  var colonyName = "".obs;
  var streetName = "".obs;
  var pincode = "".obs;



  

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
