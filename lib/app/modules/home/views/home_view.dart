import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/cart/views/cart_view.dart';
import 'package:sabzee/app/modules/home/widgets.dart';
import 'package:sabzee/app/modules/shop/views/shop_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return FutureBuilder<String>(
        future: controller.getMappedItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Scaffold(
                  body: PageView(
                    controller: controller.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // KeepAliveWrapper(
                      //   child:

                      KeepAliveWrapper(child: ShopView()),
                      KeepAliveWrapper(child: CartView()),
                      //  ),

                      //),
                    ],
                  ),
                  bottomNavigationBar: Obx(
                    () => BottomNavigationBar(
                      currentIndex: controller.currentTab.value,
                      onTap: (index) {
                        controller.currentTab.value = index;
                        controller.pageController.jumpToPage(index);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_bag_outlined),
                          label: "Shop",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart),
                          label: "Cart",
                        ),
                      ],
                    ),
                  ))
              : Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
        });
  }
}
