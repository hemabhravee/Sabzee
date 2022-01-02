import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/cart/controllers/delivery_addresses_controller.dart';
import 'package:sabzee/app/modules/cart/views/add_delivery_address_view.dart';

class DeliveryAddressesView extends GetView {
  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryAddressesController());
    var authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliveryAddressesView'),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => ListView.builder(
                shrinkWrap: true,
                itemCount: authController.sabzeeUser.addresses.length,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    elevation: 10,
                    child: Obx(() => Container(
                        color: authController
                                    .sabzeeUser.defaultAddressIndex.value ==
                                index
                            ? Get.theme.primaryColor
                            : Get.theme.backgroundColor,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 10,
                          right: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                authController
                                    .sabzeeUser.addresses.value[index].tag,
                                style: Get.textTheme.headline6),
                            Column(
                              children: [
                                authController.sabzeeUser.addresses.value[index]
                                                .line1 ==
                                            "" ||
                                        authController.sabzeeUser.addresses
                                                .value[index].line1 ==
                                            null
                                    ? Container()
                                    : Text(
                                        authController.sabzeeUser.addresses
                                            .value[index].line1,
                                      ),
                                authController.sabzeeUser.addresses.value[index]
                                                .line2 ==
                                            "" ||
                                        authController.sabzeeUser.addresses
                                                .value[index].line2 ==
                                            null
                                    ? Container()
                                    : Text(
                                        authController.sabzeeUser.addresses
                                            .value[index].line2,
                                      ),
                                authController.sabzeeUser.addresses.value[index]
                                                .street ==
                                            "" ||
                                        authController.sabzeeUser.addresses
                                                .value[index].street ==
                                            null
                                    ? Container()
                                    : Text(
                                        authController.sabzeeUser.addresses
                                            .value[index].street,
                                      ),
                                authController.sabzeeUser.addresses.value[index]
                                                .pincode ==
                                            "" ||
                                        authController.sabzeeUser.addresses
                                                .value[index].pincode ==
                                            null
                                    ? Container()
                                    : Text(
                                        authController.sabzeeUser.addresses
                                            .value[index].pincode,
                                      ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => AddDeliveryAddressView(),
                                    arguments: {
                                      'oldTag': authController
                                          .sabzeeUser.addresses.value[index].tag
                                    });
                              },
                              child: Text("edit"),
                            ),
                            TextButton(
                              onPressed: () {
                                authController.sabzeeUser.defaultAddressIndex
                                    .value = index;
                              },
                              child: Text("select"),
                            ),
                          ],
                        ))),
                  );
                }),
          ),
          ElevatedButton(
            child: Text("New address"),
            onPressed: () {
              Get.to(() => AddDeliveryAddressView(), arguments: {"oldTag": ""});
            },
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}
