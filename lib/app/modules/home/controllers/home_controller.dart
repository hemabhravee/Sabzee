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
  late RxList<MenuItem> mappedItems;
  late Future<String> getMappedItems;
  final count = 0.obs;
  @override
  void onInit() {
    // print("Fetching mapped items");
    getMappedItems = Future<String>.delayed(const Duration(seconds: 2), () {
      mappedItems = items.map((e) => MenuItem.fromJson(e)).toList().obs;
      // print("Shop controller oninit");

      return 'Data Loaded';
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
