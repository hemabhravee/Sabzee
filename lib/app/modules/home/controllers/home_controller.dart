import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';
import 'package:sabzee/app/modules/shop/views/shop_view.dart';

class HomeController extends GetxController {
  late var user = Get.arguments;

  Rx<int> currentTab = 0.obs;
  PageController pageController = PageController();
  Rx<Cart> cart = new Cart(items: [
    CartItem(itemId: "GC", variantId: "weight1", qty: 4, rate: "20"),
    CartItem(itemId: "BTG", variantId: "weight2", qty: 2, rate: "85"),
    CartItem(itemId: "PTT", variantId: "weight3", qty: 3, rate: "35"),
  ], amount: 210)
      .obs;
  late RxList<MenuItem> mappedItems;
  late Future<String> getMappedItems;

  final GlobalKey<InnerDrawerState> innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  deleteItemController() => Get.delete<ItemPageController>();

  addItemToCart(
      {required String itemId,
      required String variantId,
      required int qty,
      required String currentRate}) {
    cart.value.items.add(CartItem(
        itemId: itemId, variantId: variantId, qty: qty, rate: currentRate));
    var x = getVariantDetailsFromUID(itemId, variantId);
    int rate = int.parse(x[1]);
    cart.value.amount += qty * rate;
    update();
  }

  updateItemQuantity(
      {required int qty, required String itemId, required String variantId}) {
    var x = getVariantDetailsFromUID(itemId, variantId);
    int rate = int.parse(x[1]);
    cart.value.items.forEach((element) {
      if (element.itemId == itemId && element.variantId == variantId) {
        int diff = qty - element.qty;
        element.qty = qty;
        cart.value.amount += diff * rate;
      }
    });
    if (qty == 0) cart.value.deleteItemById(itemId, variantId);

    update();
  }

  // incrementItemQuantity(String uid) {
  //   cart.value.items.forEach((element) {
  //     if (element.uid == uid) element.qty++;
  //   });
  //   update();
  // }

  getVariantDetailsFromUID(String itemId, String variantId) {
    late String variantName, rate, itemName;
    mappedItems.forEach((item) {
      if (item.id == itemId) {
        itemName = item.name;
        item.variants.forEach((variant) {
          if (variant.id == variantId) {
            variantName = variant.name;
            rate = variant.rate;
          }
        });
      }
    });
    return [variantName, rate, itemName];
  }

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
