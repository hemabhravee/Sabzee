import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';
import 'package:sabzee/app/modules/shop/views/shop_view.dart';

class HomeController extends GetxController {
  late var user = Get.arguments;
  Rx<int> currentTab = 0.obs;
  PageController pageController = PageController();
  Rx<Cart> cart = new Cart(items: [], amount: 0).obs;
  final count = 0.obs;
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
