import 'dart:convert';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/auth/models.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController {
  Rx<PaymentMethod> paymentMethod = PaymentMethod.online.obs;
  final count = 0.obs;
  GlobalKey<ExpandableBottomSheetState> bottomSheetKey =
      new GlobalKey<ExpandableBottomSheetState>();
  final containerKey = GlobalKey();
  var sizedBoxHeight = (Get.height * 0.03).obs;
  var initDate = DateTime.now().add(Duration(
    days: 1,
  ));
  var deliveryDate = DateTime.now()
      .add(Duration(
        days: 1,
      ))
      .obs;

  var homeController = Get.find<HomeController>();
  var authController = Get.find<AuthController>();

  Future<void> selectDate(BuildContext context) async {
    deliveryDate.value = await showDatePicker(
          context: context,
          firstDate: initDate,
          lastDate: initDate.add(
            Duration(
              days: 61,
            ),
          ),
          initialDate: initDate,
          selectableDayPredicate: (DateTime date) {
            return date.weekday != DateTime.monday;
          },
        ) ??
        deliveryDate.value;
  }

  proceedToPayment() {
    if (homeController.cart.value.amount == 0) {
      Get.snackbar(
        "Your cart is empty",
        "Head to the shop section to add items to cart",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    } else {
      Map<String, dynamic> orderMap = {};

      orderMap['deliveryDate'] =
          DateFormat('dd-MM-yy').format(deliveryDate.value).toString();
      orderMap['orderDate'] =
          DateFormat('dd-MM-yy').format(DateTime.now()).toString();
      orderMap['paymentStatus'] = "unpaid";
      orderMap['cart'] = homeController.cart.value.toJson();
      orderMap['paymentMethod'] = paymentMethod.value.toString().split('.')[1];
      orderMap['deliveryAddress'] = authController.sabzeeUser.addresses
          .value[authController.sabzeeUser.defaultAddressIndex.value]
          .toJson();
      print(json.encode(orderMap));
      var order = Order.fromJson(orderMap);
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
  void increment() => count.value++;
}
