import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/cart/controllers/add_delivery_address_controller.dart';
import 'package:sabzee/app/modules/cart/widgets.dart';

class AddDeliveryAddressView extends GetView {
  @override
  Widget build(BuildContext context) {
    Get.put(AddDeliveryAddressController());
    return Scaffold(
      appBar: AppBar(
        title: Text('AddDeliveryAddressView'),
        centerTitle: true,
      ),
      body: Center(
        child: getAddressDetailsContainer(),
      ),
    );
  }
}
