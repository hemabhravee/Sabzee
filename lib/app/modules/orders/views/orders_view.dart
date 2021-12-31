import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    var user = Get.find<User>(tag: "user");
    return Scaffold(
      appBar: AppBar(
        title: Text('OrdersView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrdersView is working ${user.phoneNumber}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
