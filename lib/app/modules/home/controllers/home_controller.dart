import 'package:flutter/material.dart';
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
    CartItem(uid: "GC-weight1", qty: 4),
    CartItem(uid: "BTG-weight1", qty: 2),
    CartItem(uid: "PTT-weight1", qty: 3)
  ], amount: 210)
      .obs;
  late RxList<MenuItem> mappedItems;
  late Future<String> getMappedItems;

  deleteItemController() => Get.delete<ItemPageController>();

  addItemToCart({required String uid, required int qty}) {
    cart.value.items.add(CartItem(uid: uid, qty: qty));
    var x = getVariantDetailsFromUID(uid);
    int rate = int.parse(x[1]);
    cart.value.amount += qty * rate;
    update();
  }

  updateItemQuantity({required int qty, required String uid}) {
    var x = getVariantDetailsFromUID(uid);
    int rate = int.parse(x[1]);
    cart.value.items.forEach((element) {
      if (element.uid == uid) {
        int diff = qty - element.qty;
        element.qty = qty;
        cart.value.amount += diff * rate;
      }
    });
    if (qty == 0) cart.value.deleteItemByUid(uid);

    update();
  }

  // incrementItemQuantity(String uid) {
  //   cart.value.items.forEach((element) {
  //     if (element.uid == uid) element.qty++;
  //   });
  //   update();
  // }

  getVariantDetailsFromUID(String uid) {
    var x = uid.split('-');
    String item_id = x[0];
    String variant_id = x[1];
    late String name, rate;
    mappedItems.forEach((item) {
      if (item.id == item_id) {
        item.variants.forEach((variant) {
          if (variant.id == variant_id) {
            name = variant.name;
            rate = variant.rate;
          }
        });
      }
    });
    return [name, rate];
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
