import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EditDeliveryAddressView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditDeliveryAddressView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EditDeliveryAddressView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
