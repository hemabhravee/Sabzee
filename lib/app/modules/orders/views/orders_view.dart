import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/auth/models.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    var authController = Get.find<AuthController>();
    var homeController = Get.find<HomeController>();
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
                                margin: EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 4,
                                ),
                                color: controller.orders.value[index]
                                            .paymentStatus ==
                                        PaymentStatus.paid
                                    ? Colors.green
                                    : Colors.amberAccent,
                                child: Column(
                                  children: [
                                    Text("Order Date : " +
                                        controller
                                            .orders.value[index].orderDate),
                                    Text("Delivery Date : " +
                                        controller
                                            .orders.value[index].deliveryDate),
                                    Text("Delivery Address : \n" +
                                        controller
                                            .orders.value[index].deliveryAddress
                                            .toString()),
                                    Text("Cart Details : "),
                                    ...controller.orders.value[index].cart.items
                                        .map((item) => Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    homeController.getVariantDetailsFromUID(
                                                            item.itemId,
                                                            item.variantId)[2] +
                                                        " " +
                                                        homeController
                                                            .getVariantDetailsFromUID(
                                                                item.itemId,
                                                                item.variantId)[0],
                                                    style:
                                                        Get.textTheme.headline6,
                                                  ),
                                                  Text("rate : " + item.rate),
                                                  Text("qty : " +
                                                      item.qty.toString()),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                    Text("Amount : " +
                                        controller
                                            .orders.value[index].cart.amount
                                            .toString()),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )
                  : CircularProgressIndicator();
            }));
  }
}
