import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/cart/views/cart_view.dart';
import 'package:sabzee/app/modules/home/drawer.dart';
import 'package:sabzee/app/modules/home/keep_alive_wrapper.dart';
import 'package:sabzee/app/modules/shop/views/shop_view.dart';

import '../controllers/home_controller.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return FutureBuilder<String>(
        future: controller.getMappedItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? InnerDrawer(
                  key: controller.innerDrawerKey,
                  swipe: false,
                  colorTransitionChild:
                      Get.theme.primaryColor, // default Color.black54
                  colorTransitionScaffold:
                      Colors.transparent, // default Color.black54
                  backgroundDecoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                  ),
                  //When setting the vertical offset, be sure to use only top or bottom
                  offset: IDOffset.only(bottom: 0.05, right: 0.5, left: 0.0),
                  // scale: IDOffset.horizontal(0.8),
                  borderRadius: 0, // default 0
                  leftAnimationType: InnerDrawerAnimation.quadratic,
                  leftChild:
                      getDrawer(context), // required if rightChild is not set

                  scaffold: Scaffold(
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
                      )),
                )
              : Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
        });
  }
}
