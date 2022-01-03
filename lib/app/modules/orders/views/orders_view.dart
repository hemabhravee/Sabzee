import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    var authController = Get.find<AuthController>();
    return Scaffold(
        appBar: AppBar(
          title: Text('OrdersView'),
          centerTitle: true,
        ),
        body: FutureBuilder<Object>(
            future: controller.getOrders(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                      child: Obx(
                        () => ListView.builder(
                            itemCount: controller.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Text(
                                    controller.orders.value[index].orderDate),
                              );
                            }),
                      ),
                    )
                  : CircularProgressIndicator();
            }));
  }
}
