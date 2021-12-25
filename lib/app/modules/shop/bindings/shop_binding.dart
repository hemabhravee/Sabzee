import 'package:get/get.dart';

import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';

import '../controllers/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemPageController>(
      () => ItemPageController(),
    );
    Get.lazyPut<ShopController>(
      () => ShopController(),
    );
  }
}
