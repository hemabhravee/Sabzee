import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    var homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('CartView'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Obx(() => ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: homeController.cart.value.items.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(homeController.cart.value.items[index]['item'].name),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: homeController
                              .cart.value.items[index]['item'].variants.length,
                          itemBuilder: (context, index2) {
                            return Text("Selections");
                          }),
                    ),
                    Text(homeController.cart.value.items[index]['cost']
                        .toString()),
                  ],
                );
              })),
        ),
      ),
    );
  }
}
