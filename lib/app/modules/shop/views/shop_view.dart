import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/orders/views/orders_view.dart';
import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';
import 'package:sabzee/app/modules/shop/widgets/shop_item_card_modal_bottom_sheet.dart';

import '../controllers/shop_controller.dart';

import 'package:sabzee/app/modules/shop/models.dart';

class ShopView extends GetView<ShopController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ShopController());
    var homeController = Get.find<HomeController>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Obx(() => controller.isSearching.value
      //       ? controller.searchField.value
      //       : controller.appBarTitle.value),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     new IconButton(
      //         onPressed: () {
      //           print("Search Button Pressed");
      //           if (controller.actionIcon.value.icon == Icons.search) {
      //             print("Search Button Pressed");
      //             controller.actionIcon.value =
      //                 new Icon(Icons.close, color: Colors.white);
      //             controller.isSearching.value = true;
      //           } else {
      //             controller.isSearching.value = false;
      //             controller.actionIcon.value =
      //                 new Icon(Icons.search, color: Colors.white);
      //             print("Exiting Search");
      //           }
      //         },
      //         icon: Obx(() => controller.actionIcon.value))
      //   ],
      // ),

      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            snap: true,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                width: Get.width,
                color: Colors.grey,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        homeController.innerDrawerKey.currentState?.open();
                      },
                      icon: Icon(Icons.menu),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        child: Obx(() => controller.isSearching.value
                            ? controller.searchField.value
                            : controller.appBarTitle.value),
                      ),
                    ),
                    IconButton(
                      onPressed: controller.searchButtonHandler,
                      icon: Obx(() => controller.actionIcon.value),
                    ),
                  ],
                ),
              ),
              background: FlutterLogo(),
            ),
            actions: <Widget>[],
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    controller.searchFocusNode.unfocus();
                    controller.isSearching.value = false;
                    controller.actionIcon.value =
                        new Icon(Icons.search, color: Colors.white);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 15,
                    ),
                    color: Colors.teal[100 * ((index + 1) % 9)],
                    // height: Get.height * 0.3,
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                            height: Get.height * 0.23,
                            width: Get.width,
                            color: Colors.amber,
                            child: const Image(
                              image: NetworkImage(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                            )),
                        Text(homeController.mappedItems.value
                            .elementAt(index)
                            .name),
                        Text((homeController.mappedItems.value
                                    .elementAt(index)
                                    .variants
                                    .length)
                                .toString() +
                            " variants available"),
                        TextButton(
                          onPressed: () async {
                            // Get.to(() => ItemPageView(),
                            //    arguments: [index]);

                            customModalBottomSheet(context, index);
                          },
                          child: Text("Add"),
                        )
                      ],
                    )),
                  ),
                );
              },
              childCount: homeController.mappedItems.value.length,
            ),
          ),
        ],
      ),
      // GestureDetector(
      //     child: Center(
      //       child: Container(
      //         height: Get.height,
      //         width: Get.width,
      //         child: CustomScrollView(
      //           primary: false,
      //           slivers: <Widget>[
      //             SliverPadding(
      //               padding: const EdgeInsets.all(0),
      //               sliver: SliverGrid.count(
      //                 crossAxisSpacing: 10,
      //                 mainAxisSpacing: 10,
      //                 crossAxisCount: 2,
      //                 children: <Widget>[
      //                   Container(
      //                     //padding: const EdgeInsets.all(8),
      //                     child: const Text("He'd have you all unravel at the"),
      //                     color: Colors.green[100],
      //                   ),
      //                   Container(
      //                     //padding: const EdgeInsets.all(8),
      //                     child: const Text('Heed not the rabble'),
      //                     color: Colors.green[200],
      //                   ),
      //                   Container(
      //                     //padding: const EdgeInsets.all(8),
      //                     child: const Text('Sound of screams but the'),
      //                     color: Colors.green[300],
      //                   ),
      //                   Container(
      //                     //padding: const EdgeInsets.all(8),
      //                     child: const Text('Who scream'),
      //                     color: Colors.green[400],
      //                   ),
      //                   Container(
      //                     //padding: const EdgeInsets.all(8),
      //                     child: const Text('Revolution is coming...'),
      //                     color: Colors.green[500],
      //                   ),
      //                   Container(
      //                     //padding: const EdgeInsets.all(8),
      //                     child: const Text('Revolution, they...'),
      //                     color: Colors.green[600],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     onTap: () {
      //       controller.searchFocusNode.unfocus();
      //       controller.isSearching.value = false;
      //       controller.actionIcon.value =
      //           new Icon(Icons.search, color: Colors.white);
      //     }),
    );
  }
}
