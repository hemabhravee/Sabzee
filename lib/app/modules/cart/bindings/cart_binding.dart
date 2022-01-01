import 'package:get/get.dart';

import 'package:sabzee/app/modules/cart/controllers/add_delivery_address_controller.dart';
import 'package:sabzee/app/modules/cart/controllers/delivery_addresses_controller.dart';

import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDeliveryAddressController>(
      () => AddDeliveryAddressController(),
    );
    Get.lazyPut<DeliveryAddressesController>(
      () => DeliveryAddressesController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
