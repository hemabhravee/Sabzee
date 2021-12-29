import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
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

      body: FutureBuilder<String>(
          future: controller.getMenuItems(),
          builder: (context, snapshot) {
            return ExpandableBottomSheet(
              persistentHeader: Container(
                // key: controller.containerKey,
                color: Colors.orange,
                height: Get.height * 0.03,
                child: Center(
                  child: Container(
                    height: Get.height * 0.007,
                    width: Get.width * 0.1,
                    color: Color.fromARGB((0.25 * 255).round(), 0, 0, 0),
                  ),
                ),
              ),
              expandableContent: Container(
                height: Get.height * 0.3,
                width: Get.width,
                color: Colors.white,
                child: Wrap(
                  children: [
                    ...controller.categories.map((e) => Container(
                          // height: Get.height * 0.05,
                          color: Colors.lightBlue,
                          child: Text(e),
                        )),
                  ],
                ),
              ),
              background: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    centerTitle: true,
                    snap: true,
                    floating: true,
                    expandedHeight: Get.height * 0.15,
                    collapsedHeight: Get.height * 0.10,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                        width: Get.width,
                        height: Get.height * 0.1,
                        // color: Colors.grey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    homeController.innerDrawerKey.currentState
                                        ?.open();
                                  },
                                  icon: Icon(Icons.menu),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.black,
                                    child: Obx(() =>
                                        controller.isSearching.value
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
                            Row(
                              children: [
                                ...controller.categories
                                    .map((category) => GestureDetector(
                                          onTap: () => controller
                                              .switchCategory(category),
                                          child: Obx(() => Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.005,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.001,
                                                  vertical: Get.height * 0.005,
                                                ),
                                                height: Get.height * 0.03,
                                                width: Get.width * 0.15,
                                                color: category ==
                                                        controller
                                                            .currentCategory
                                                            .value
                                                    ? Colors.blue[900]
                                                    : Colors.grey,
                                                child: Center(
                                                  child: Text(
                                                    category,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                              )),
                                        ))
                                    .toList(),
                              ],
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
                        child:
                            Text('Scroll to see the SliverAppBar in effect.'),
                      ),
                    ),
                  ),
                  Obx(
                    () => SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  Text(controller.displayItems.value
                                      .elementAt(index)
                                      .name),
                                  Text((controller.displayItems.value
                                              .elementAt(index)
                                              .variants
                                              .length)
                                          .toString() +
                                      " variants available"),
                                  TextButton(
                                    onPressed: () async {
                                      // Get.to(() => ItemPageView(),
                                      //    arguments: [index]);
                                      String item_id = controller
                                          .displayItems.value
                                          .elementAt(index)
                                          .id;
                                      customModalBottomSheet(context, item_id);
                                    },
                                    child: Text("Add"),
                                  )
                                ],
                              )),
                            ),
                          );
                        },
                        childCount: controller.displayItems.length,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

var categories = [
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
];
