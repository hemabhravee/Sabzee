import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    return Scaffold(
        appBar: AppBar(
          title: Text('OrdersView'),
          centerTitle: true,
        ),
        body: authController.sabzeeUser.orders.isEmpty
            ? Center(
                child: Text(
                  'You have made no orders yet',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : Center(
                child: Text(
                  'Orders',
                  style: TextStyle(fontSize: 20),
                ),
              ));
  }
}
