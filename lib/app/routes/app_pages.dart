import 'package:get/get.dart';

import 'package:sabzee/app/modules/cart/bindings/cart_binding.dart';
import 'package:sabzee/app/modules/cart/views/cart_view.dart';
import 'package:sabzee/app/modules/home/bindings/home_binding.dart';
import 'package:sabzee/app/modules/home/views/home_view.dart';
import 'package:sabzee/app/modules/orders/bindings/orders_binding.dart';
import 'package:sabzee/app/modules/orders/views/orders_view.dart';
import 'package:sabzee/app/modules/shop/bindings/shop_binding.dart';
import 'package:sabzee/app/modules/shop/views/shop_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SHOP,
      page: () => ShopView(),
      binding: ShopBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
  ];
}
